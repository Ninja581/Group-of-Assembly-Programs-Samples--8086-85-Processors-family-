
TITLE secret message
.MODEL SMALL
.STACK 100H
.DATA
CODE_KEY DB 65 DUP(''),'XQPOGHZBCADEIJUVFMNKLRSTWY'
DB 37 DUP (' ')
DECODE_KEY DB 65 DUP(''),'JHIKLQEFMNTURSDCBVWXOPYAZG'
DB 37 DUP (' ')
CODED DB 80 DUP ('$')
PROMPT DB 'ENTER A MESSAGE :' , 0DH ,0AH , '$'
CRLF DB 0DH , 0AH , '$'
.CODE
MAIN PROC
; initialize DS
MOV AX,@DATA
MOV DS,AX
;print user prompt
LEA DX,PROMPT
MOV AH,09H
INT 21H
;READ AND ENCODE MESSAGE
MOV AH , 1
LEA BX , CODE_KEY
LEA DI , CODED
WHILE_:
INT 21H
CMP AL , 0DH
JE END_WHILE
XLAT
MOV [DI],AL
INC DI
JMP WHILE_
END_WHILE:
;GOTO NEW LINE
MOV AH , 9
LEA DX , CRLF
INT 21H
;PRINT ENCODED MESSAGE
LEA DX,CODED
INT 21H
;GOTO NEW LINE
LEA DX,CRLF
INT 21H
;DCODE MESSAGE AND PRINT IT
MOV AH , 2
LEA BX , DECODE_KEY
LEA SI , CODED
WHILE2:
MOV AL , [SI]
CMP AL ,'$'
JE END_WHILE2
XLAT
MOV DL ,AL
INT 21H
INC SI
JMP WHILE2
END_WHILE2:
;return to DOS
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN