#Remove extra space surrounding binary operator
s:[^//].*\(\s*[\+,-,\*,/,=,==,<=,>=,<,>]\s*\).*: \(1\) :g
