[org 0x7c00]

	[bits 16]
		mov bp, 0x9000
		mov sp, bp
	
		call switch_to_pm
			
		jmp $
 
	%include 'gdt.asm'
 
		switch_to_pm:
			cli
			lgdt [gdt_descriptor]
			mov eax, cr0
			or eax, 0x1
			mov cr0, eax
			
		jmp KERNEL_CODE_SEG:pm_switched
 
	[bits 32]
 
		pm_switched:
			mov ax, KERNEL_DATA_SEG
			mov ds, ax
			mov ss, ax
			mov es, ax
			mov fs, ax
			mov gs, ax
			mov ebp, 0x90000
			mov esp, ebp
			
		jmp $
 
	times 510-($-$$ ) db 0
	dw 0xaa55
