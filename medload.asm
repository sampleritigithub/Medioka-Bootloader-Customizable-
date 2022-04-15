;ORSOFT Bootloader
;Copyrights:
;Omar Ismail

comp db "medos"
mov bx, comp
MOV AH, 0x0e
MOV AL, "O"
INT 0x10
MOV AL, "R"
INT 0x10
MOV AL, "S"
INT 0x10
MOV AL, "O"
INT 0x10
MOV AL, "F"
INT 0x10
MOV AL, "T"
INT 0x10
MOV AL, ":"
INT 0x10
MOV AX, "Mastered"

call ReadDrive
jmp programspace
programspace equ 0x7e00
mov [bootdisk], dl
ReadDrive:
    ; Disk Bootloader Run ;
    ; Not very Important to learn ;
    mov al, "|"
    INT 0x10
    mov al, "|"
    INT 0x10
    mov al, "|"
    INT 0x10
    mov ah, 0x02
    mov bx, programspace
    mov al, 32	 ; Disk Stuff you must do
    mov dl, [bootdisk]
    mov ch, 0x00 ; Cylinder
    mov dh, 0x00 ; Head
    mov cl, 0x02 ; Sector
    int 0x13 ; BIOS Interrupt
    mov ah, 0x0e
    mov al, "|"
    int 0x10
    mov al, "|"
    INT 0x10
    mov al, "|"
    INT 0x10
    jc DiskReadFailed
    ret

bootdisk:
	db 0 ; Drive data

DiskReadFailed:
	; If the NT or the ORSOFT kernel is missing or corrupted: ;
	mov ah, 0x0e
	mov al, '!'
	int 0x10
	jmp $
