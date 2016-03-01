***********************************
*** art1_p2_margenes			***
*** Ing. RoyCalderon 05 01 2015 *** 
*** Muestra y Actualiza margenes***
***********************************

*******************************
*** Aceptar *** click() 	***
*******************************

?tconnect = SQLCONECTAR()
If  mensaje_sql(tconnect,0) <= 0
	Return .F.
Endif

*PARAMETERS pForm1


*thisform.Text1.refresh
*mv1= cast(thisform.Text1.text as float (8,2))
*messagebox(mv1)
*mv1= cast(thisform.Text1.value as float (8,2))
*messagebox(mv1)

*mv1= (thisform.Text1.text)
*messagebox(mv1)
*mv1= (thisform.Text1.value)
*messagebox(mv1)



sublinea=thisform.Combo.ListItem(thisform.Combo.ListIndex,1)

mv1= (thisform.n_mv1.value)
mv2= (thisform.n_mv2.value )
mv3= (thisform.n_mv3.value )
mv4= (thisform.n_mv4.value )
flete=(thisform.n_flete.value)
iva= (thisform.n_iva.value )

*messagebox(sublinea+" "+mv1+" "+mv2+" "+mv3+" "+flete+" "+iva)
*messagebox(thisform.Combo.ListItem(thisform.Combo.ListIndex,1))

fechaHoy=date()
horaHoy=time()
fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

*String
*messagebox(fechaHora)
*Datetime
*messagebox(convert(datetime,fechaHora,131))

sql_con=" update aAa_margenesG set mv1=?mv1, mv2=?mv2, mv3=?mv3,mv4=?mv4,flete=?flete,iva=?iva, fechaModificacion=convert(datetime,?fechaHora,131);
where co_subl=?sublinea"

tresult1=sqlexec(tconnect,sql_con)
If mensaje_sql(tresult1,":.: Proceso Actualizacion De Margenes  --> ERROR!!!! :: Dpto Informatica :) :: Compresores Servicios :.:","Error sql Actualizando") <= 0
   Return .F.
else
	messagebox(":.: Proceso Actualizacion De Margenes  --> COMPLETADO :.:",64,"Dpto Informatica :) :: Compresores Servicios::")
ENDIF


*******************************
*** Form1 *** init() 		***
*******************************

LPARAMETERS v_sublin


	MESSAGEBOX(":.: AVISO :.:"+Chr(13)+"De momento no se ven los margenes guardados en base de datos."+Chr(13)+" --> Proximamente se agregara esta caracteristica! <-- "+Chr(13)+"Mientras tanto puede continuar cambiando los valores sin novedad y para visualizar los datos puede usar el Excel que esta en la carpeta de tecnologias del servidor. Recuerde usar *Actualizar Datos* en la pestana datos de excel.",64,"::Dpto Informatica :) Compresores Servicios::")

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

tresult=sqlexec(tconnect,'select co_subl from aAa_margenesG','V_SUBLIN')

this.v_sublin=V_SUBLIN
public sublineas;

sublineas=V_SUBLIN

do while !EOF('v_sublin')
	thisform.Combo.AddItem (v_sublin.co_subl)
skip in v_sublin
enddo


***************************************
*** Combo *** interactiveChange()	***
***************************************

* thisform.iva.value=thisform.Combo.ListItem(thisform.Combo.ListIndex,1)
* thisform.flete.value=thisform.Combo.ListIndex

*Eso de abajo hace lo que se requiere... El detalle es traerse la data 
*Si hago la conex aqui se tira... 3 ... 
do while !EOF('sublineas')
	if (this.sublineas.co_subl=thisform.Combo.ListItem(thisform.Combo.ListIndex,1))
		thisform.a_mv1.value=sublineas.mv1
		thisform.a_mv2.value=sublineas.mv2
		thisform.a_mv3.value=sublineas.mv3
		thisform.a_mv4.value=sublineas.mv4
		thisform.a_flete.value=sublineas.flete
		thisform.a_iva.value=sublineas.iva
	endif
skip in sublineas
enddo