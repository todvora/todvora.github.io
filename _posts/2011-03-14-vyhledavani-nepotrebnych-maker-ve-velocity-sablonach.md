---
layout: post
title: Vyhledávání nepotřebných maker ve velocity šablonách
date: '2011-03-14 09:27:55'
tags:
- velocity
- makro
- apache
- python
- šablony
- template
---

Jednoduchý script pro nalezení všech definovaných maker ve velocity
šablonách a následně procházením šablon vypsání všech
nepoužitých.


<p>Pokud používáte v projektu pro šablonování <a
href="http://velocity.apache.org/">Apache Velocity</a> a k tomu i <a
href="http://velocity.apache.org/engine/releases/velocity-1.7/user-guide.html#Velocimacros">Makra</a>,
pak brzy zjistíte že se Vám v projektu hromadí nepoužitá makra,
která měla smysl možná někdy v historii, refaktoringem ale už
ztratily význam. Taková makra se pokouší nalézt následující scriptík
v pythonu:</p>

<pre><code>import sys
import re
import os
import fnmatch

class Macro:
    def __init__(self, file, line_number, line, macro_name, macro_params):
        self.file = file
        self.line_number = line_number
        self.line = line
        self.macro_name = macro_name
        self.usages_count = 0
        self.regex = re.compile(self._get_regular_expression(macro_params))

    def _get_regular_expression(self, macro_params):
        params = macro_params.strip().split(&quot; &quot;)
        regex = &quot;#&quot; + self.macro_name + &quot;\s*?\(&quot;
        params_regex = []
        for param in params:
            if len(param.strip()) &gt; 0:
                params_regex.append(&quot;\S+?|\'.+?\'|\&quot;.+?\&quot;&quot;)
        regex = regex + '\w+?'.join(params_regex) + &quot;\)&quot;
        return regex

    def get_regex(self): return self.regex

    def addusage(self, count): self.usages_count = self.usages_count + count

    def getusage(self): return self.usages_count

macros = []
macro_regex = re.compile('#macro\s*?\((\w+)(.*?)\)')
def callback(arg, dirname, fnames):
    for filename in fnames:
        if fnmatch.fnmatch(filename, '*.vm'):
            simpleFile = dirname.replace(os.getcwd(), &quot;&quot;, 1) +&quot;/&quot;+ filename
            file = open(dirname + &quot;/&quot; +  filename)
            lines_counter = 0
            for line in file:
                lines_counter = lines_counter + 1
                line = line.strip()
                match = macro_regex.search(line)
                if(match is not None):
                    macro = Macro(simpleFile, lines_counter, line, match.group(1), match.group(2))
                    macros.append(macro)

os.path.walk(&quot;.&quot;, callback, None)
print &quot;Found &quot; + str(len(macros)) + &quot; defined macros, searching for usages ...&quot;

def callback2(arg, dirname, fnames):
    for macro in macros:
        for filename in fnames:
            if fnmatch.fnmatch(filename, '*.vm'):
                filecontent = open(dirname + &quot;/&quot; +  filename).read()
                result = macro.get_regex().findall(filecontent)
                macro.addusage(len(result))

os.path.walk(&quot;.&quot;, callback2, None)

not_used_macros = []

for macro in macros:
    if macro.getusage() &lt; 1:
        not_used_macros.append(macro)

if len(not_used_macros) &gt; 0:
    sys.stdout.write(&quot;Found &quot; + str(len(not_used_macros)) + &quot; not used velocity macros!\n&quot;)
    for macro in not_used_macros:
        sys.stdout.write(macro.file + &quot;:&quot; + str(macro.line_number) + &quot;: &quot; + macro.line + &quot;\n&quot;)
    exit(1)
else:
    print &quot;Done, every detected velocity macro is used somewere&quot;
    exit(0)</code></pre>

<hr />

<p><strong>Výstup scriptu na datech jednoho z našich
projektů:</strong></p>

<pre><code>python uselessmacros.py

Found 238 defined macros, searching for usages ...
Found 21 not used velocity macros!
./vm/LayoutMacros.vm:159: #macro (get_script_tynt)
./vm/LayoutMacros.vm:176: #macro(get_script_navrcholu)
./vm/LayoutMacros.vm:250: #macro(has_intro_action_courses)
./vm/Macros.vm:615: #macro(context_info)
./vm/CompaniesMacros.vm:7: #macro (show_website_thumbnail)
./vm/CoursesMacros.vm:368: #macro (show_language_course_invalid_text)
./vm/CoursesMacros.vm:382: #macro (show_language_course_invalid_warning)
./vm/CoursesMacros.vm:398: #macro (show_languages_count)
./vm/CoursesMacros.vm:789: #macro (show_scheduled_language_courses)
./vm/CoursesMacros.vm:809: #macro (show_custom_language_courses)
./vm/CoursesMacros.vm:1256: #macro (show_course_company_actions)
./vm/CoursesMacros.vm:1266: #macro (show_language_company_actions)
./vm/CoursesMacros.vm:1276: #macro (show_consulting_company_actions)
./vm/CoursesMacros.vm:1353: #macro(show_language_course_actions_first_part)
./vm/CoursesMacros.vm:1357: #macro(show_language_course_actions_second_part)
./vm/CoursesMacros.vm:1470: #macro (show_consulting_actions)
./vm/CoursesMacros.vm:1551: #macro (show_company_in_course)
./vm/CoursesMacros.vm:1628: #macro (show_company_in_course_with_features)
./vm/CoursesMacros.vm:1686: #macro (show_company_in_language_course)
./vm/CoursesMacros.vm:1690: #macro (show_company_in_language_course_with_features)
./vm/CoursesMacros.vm:1750: #macro (show_company_in_consulting)</code></pre>

