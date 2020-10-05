; Egor Panfilov, group 194
;
; Task 17: all negative elements after last positive element

format PE console

entry START

include 'win32a.inc'

section '.data' data readable writable

        strInputN db 'Input N (0;100): ', 0
        strInputArray db 'Input element [%d]: ', 0
        procD db '%d', 0
        space db ' ', 0
        strWrongN db 'Incorrect N', 0

        n dd ?
        ii dd ?
        elem dd ?
        arrayA dw 100 dup 0
        arrayB dw 100 dup 0

        null = 0
        hundred = 100

section '.code' code readable executable

        START:
                cinvoke printf, strInputN
                cinvoke scanf, procD, n
                mov [elem], -1
                mov eax, [n]
                mov ebx, null
                cmp eax, ebx
                jle incorrectN
                mov ebx, hundred
                cmp eax, ebx
                jge incorrectN


                mov [ii], null
                mov ebx, arrayA
        loop1:
                mov eax, [ii]
                cmp eax, [n]
                je loop2Preparing

                cinvoke printf, strInputArray, [ii]
                push ebx
                push procD
                call [scanf]

                mov eax, [ebx]
                cmp eax, null
                jns lastEvenIf
                loop1Continue:

                mov eax, [ii]
                add eax, 1
                mov [ii], eax

                add ebx, 4

                jmp loop1

        loop2Preparing:

                mov [ii], null
                mov ebx, arrayA
                mov ecx, arrayB

        loop2:
                mov eax, [ii]
                cmp eax, [n]
                je finish

                cmp eax, [elem]
                jle continue

                mov ecx, ebx

                cinvoke printf, procD, [ecx]
                cinvoke printf, space

                add ecx, 4

                continue:
                add ebx, 4

                mov eax, [ii]
                add eax, 1
                mov [ii], eax

                jmp loop2


        finish:
                call [getch]
                push null
                call [ExitProcess]


        lastEvenIf:
                mov edx, ebx
                mov ecx, [ii]
                mov [elem], ecx
                jmp loop1Continue

        incorrectN:
                cinvoke printf, strWrongN
                jmp finish


section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'
