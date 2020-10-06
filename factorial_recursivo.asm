
## SALTO A LA FUNCION QUE CALCULA EL FACTORIAL
jal         factorial              # jump to "factorial" target and save position to $ra

## FINALIZACION DEL PROGRAMA
li		      $v0, 10		        # syscall halt code
syscall

## FUNCION QUE CALCULA EL FACTORIAL Y GUARDA DATOS EN LA PILA
factorial:
## Guardo $SP(STACK-POINTER), $S0(NUMBER)
addi        $sp, $sp, -8      # hago lugar en la pila
sw          $ra, 0($sp)       # push $ra
sw          $s0, 4($sp)       # push $s0 (number)
j           loop              # jump to loop

## Operacion loop del factorial
loop:
beq		      $a2, $zero, exit  # if $a2 == 0 go to exit
mul         $s0, $s0, $a2     # number *=  number-1
addi		    $a2, $a2, -1      # $a2 = $a2--
jal         loop              # jump to loop again and save position to $ra

## Imprimo el resultado factorial
exit:
li          $v0, 1            # syscall print int code
move        $a0, $s0          # move $s0 to $a0
syscall

## Se traen los datos de la pila y se restaura el espacio de la pila
lw          $ra, 0($sp)       # recupero el valor de $ra
lw          $s0, 4($sp)       # recupero el valor de $s0 (numero original)
addi        $sp, $sp, 8       # recupero el espacio utilizado en la pila

## Vuelvo a la instruccion que le sigue al sal (Finaliza programa)
jr          $ra

## CASO 1 y 0 => Imprimo el numero y termino programa
bye:
li          $v0, 1            # syscall print int code
move        $a0, $s0          # move $s0 to $a0
syscall
li		      $v0, 10		        # syscall halt code
syscall
