#Remove extra space surrounding binary operator
s:\( *[\+,-,\*,/,=,==,<=,>=,<,>]{1} *\): \(1\) :g
#s/ *\+ */ \+ /g
#s/ *- */ - /g
#s/ *\* */ \* /g
#s/ *\/[^\/\*\*] */ \/ /g
#s/ *= */ = /g
#s/ *== */ == /g
#s/ *<= */ <= /g
#s/ *>= */ >= /g
#s/ *< */ < /g
#s/ *< */ < /g
