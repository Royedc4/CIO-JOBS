*******************************************************************************
*** Objeto: Form_Lista_empaque
*** Evento: LOAD
*** Ing. RoyCalderon -- 12/05/15
*******************************************************************************
PUBLIC load_fact_num, canRenglones
load_fact_num=_screen.activeform.pageframe1.page1.fact_num1.value

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

tresult=sqlexec(tconnect,'SELECT COUNT(*) as cantidad FROM reng_ndd WHERE fact_num=?load_fact_num','c_renglones')
canRenglones=c_renglones.cantidad
*messagebox(canRenglones)


*******************************************************************************
*** Button Guardar Renglon
*** Ing. RoyCalderon -- 12/05/15
*** Guarda el comentario en el rango de renglones seleccionado...
*******************************************************************************

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

*** Getting Form Values
	rIni=thisform.t_ini.value
	rFin=thisform.t_fin.value
	rComment=thisform.t_bulto.value

IF (rFin>canRenglones)
	messagebox("El rango final de renglon es incorrecto, verifique la informacion.",16,":.: Proceso Lista Empaque  --> ERROR :.:")
	thisform.t_fin.setFocus()
ELSE
	sql_con="UPDATE reng_ndd SET comentario='BULTO '+?ALLTRIM(STR(rComment)) WHERE fact_num=?load_fact_num AND reng_num BETWEEN ?rIni AND ?rFin"
	tresult1=sqlexec(tconnect,sql_con)
	If mensaje_sql(tresult1,":.: Proceso Lista Empaque  --> ERROR!!!! :: Dpto Informatica :) :: Compresores Servicios :.:","Error sql Actualizando, contacte a Informatica con este codigo:5123") <= 0
		thisform.t_ini.setFocus()
		Return .F.
	else
		thisform.t_ini.setFocus()
ENDIF
ENDIF


*******************************************************************************
*** Button Guardar Bultos
*** Ing. RoyCalderon -- 12/05/15
*** Guarda Bultos y Finaliza el proceso
*******************************************************************************

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

*** Getting Form Value
	t_canBultos=thisform.t_bulto.value

sql_con="UPDATE not_dep SET comentario=?ALLTRIM(STR(t_canBultos)) WHERE fact_num=?load_fact_num"
tresult1=sqlexec(tconnect,sql_con)
If mensaje_sql(tresult1,":.: Proceso Lista Empaque  --> ERROR!!!! :: Dpto Informatica :) :: Compresores Servicios :.:","Error sql Actualizando") <= 0
   Return .F.
else
	messagebox(":.: Proceso Lista Empaque  --> COMPLETADO :.:",64,"Dpto Informatica :) :: Compresores Servicios::")
	thisform.release()
ENDIF

