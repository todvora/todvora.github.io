---
layout: post
title:  "Hunting for the OOM bug in my test suite"
date:   2015-03-14 05:51:47
categories: java tests
---
You know it, you have probably experienced it too. Your tests are slowing down, memory consumption is rising, the CPU is burning itself. There has to be a bug somewhere. Maybe one bad line of code, that ruins everything. But how can you find it?

With all the modern hardware is easy to overlook, that something has gone wrong. My working computer (i7, 16G RAM) should be fast enough to run simple test suite of 350 tests. But one day, the tests started to failing. The OutOfMemory error happened every time. Initially I thought, that one of the latest tests is to blame. But reverting several commits back didn't helped. The error was still there. It has to be something tricky, that slowly eats all the memory. With every added test it slows the whole suite down. How can you find it?

### Visualize your VM
Luckily there is a tool included in JDK distribution, that helps you detect regressions like this. It's called [Java VisualVM](http://visualvm.java.net/). It connects to JVM and displays memory/CPU usage, threads, heap and most important - the types and counts of objects, that stays in the memory. 

![Memory consumption, failing tests](/images/oom/graph_failed.png)

All the symptoms are there - memory consumption is quickly rising, the GC runs more and more often, the CPU goes crazy. Lets see, what are the objects in our memory.

![Memory dump, tests failing](/images/oom/memory_failed.png)

### Mockito to blame?

My tests use the [Mockito framework](http://mockito.org/). I love Mockito. Simple, elegant and powerful. But 2 500 000 of [InvocationImpl](https://github.com/mockito/mockito/blob/master/src/org/mockito/internal/invocation/InvocationImpl.java) objects is too much. These objects holds all the information about mock invocations. Mainly for later verification. Usually something like this:


```
Mockito.verify(myActionMock, Mockito.times(3)).invoke();
```

It means: the method ```invoke()``` should be called exactly 3 times on my mock/object ```myActionMock```. To achieve this, Mockito records every interaction with the mocked object. 

But there shouln't be 2.5M of invocation records constantly stored in my memory. They are not released properly and the GC cannot throw them away. The count of invocations says, that they are heavily used. In this moment I had to go through my tests and find something suspicious. Something, that is able to survive through all the test runs. Something ... static!

### Stinky static code

```
@Before
public void setUp() throws Exception {
	Appender appender = Mockito.mock(Appender.class);
	LogManager.getRootLogger().addAppender(appender);
}
```

This setUp seems strange. Mainly because there is no @After method, that removes this [Appender](https://logging.apache.org/log4j/2.x/manual/appenders.html). It is static. It is logging - so heavily used indeed. And it is not cleaned up. We probably found our suspect. Quick debugging session confirmed this idea. The appenders are added and never removed.

Lets add to every affected test simple cleanup method:


```
@After
public void tearDown() throws Exception {
	LogManager.getRootLogger().removeAppender(appender);
}
```

And bingo! The tests are not failing anymore, memory usage is back to normal, the CPU is relaxing. 

![Memory consumption, tests OK](/images/oom/graph_ok.png)

There are no instances of ```InvocationImpl``` in the top of the charts.

![Memory dump, tests OK](/images/oom/memory_ok.png)

### Lesson learned
Be cautious when you are dealing with static code. Especially, when you are passing mocks, that records every interaction. Clean up all the tests resources you created. And mainly, use the tools given to you. Without [JVisualVM](http://visualvm.java.net/) I would be hunting this bug till now. 
