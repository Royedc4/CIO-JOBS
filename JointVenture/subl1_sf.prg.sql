**********************************************************************************************************
*** Insert de sublinea en tablas de procesos especiales (subl1_sf.prg)
**********************************************************************************************************
*** Al insertar una nueva sublinea en el sistema se añadira automaticamente a las tablas necesarias.
**********************************************************************************************************
*** Roy Enero 2015
**********************************************************************************************************

alias_w=alias() 
*** Taking Value
x1_co_subl=sub_lin.co_subl
If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
ENDIF
	tresult=sqlexec(tconnect,'INSERT INTO aAa_margenesG (co_subl,mv1,mv2,mv3,mv4,flete,iva) values (?x1_co_subl,0,0,0,0,0,0)')
	If mensaje_sql(tresult,1,"Sublinea ya forma parte de la tabla de margenes de ganancia.") <= 0
	   Return .F.
	else
		MESSAGEBOX(":.: Sublinea Guardada exitosamente en tabla de margenes de ganancia.  :.: .",64,"::Dpto Informatica :) Compresores Servicios::")
	ENDIF