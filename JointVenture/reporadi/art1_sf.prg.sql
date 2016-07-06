***********************************************************************************************************
*** Insert de articulo en tablas de procesos especiales (subl1_sf.prg)									***
***********************************************************************************************************
*** Al insertar un nuevo articulo:																		***
*** 1. Se añadira automaticamente a las tablas de procesos especiales(Margenes de ganancias) necesarias.***
*** 2. Se configurara la foto para que este en \Pictures con el mismo codigo del articulo.				***
***********************************************************************************************************

alias_w=alias() 
*** Taking Value
x1_co_art=art.co_art
If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
ENDIF


***********************************************************************************************************
*** 1. Se añadira automaticamente a las tablas de procesos especiales(Margenes de ganancias) necesarias.***
***********************************************************************************************************

	tresult=sqlexec(tconnect,'INSERT INTO aAa_MargenesGArt (co_art,mv1,mv2,mv3,mv4,flete,iva) values (?x1_co_art,0,0,0,0,0,0)')
	*If mensaje_sql(tresult,1,"Articulo ya forma parte de la tabla de margenes de ganancia.") <= 0
	*   foo=bar
	*	else
	*		MESSAGEBOX(":.: Articulo Guardado exitosamente en tabla de margenes de ganancia.  :.: .",64,"::Dpto Informatica :) Compresores Servicios::")
	*ENDIF

***********************************************************************************************************
*** 2. Se configurara la foto para que este en \Pictures con el mismo codigo del articulo.				***
***********************************************************************************************************

	queryArt="UPDATE ART SET dis_cen=CONCAT('*-*(D:\PROFIT\PICTURES\',RTRIM('" +x1_co_art+ "'),'.PNG)*-*') where co_art=RTRIM('" +x1_co_art+ "')"
	
	tresult=sqlexec(tconnect,queryArt)
	If mensaje_sql(tresult,1,"Error sql Actualizando DIS_CEN") <= 0
		messagebox(queryArt)
		messagebox(tresult)
		Return .F.
	else
		messagebox(":.: Procesos Adicionales :.:"+Chr(13)+Chr(13)+"1. Se agrego el articulo a la tabla de margenes para su definicion de margen."+Chr(13)+Chr(13)+"2. Se le asigno la imagen al producto. Depende del equipo de almacen cargarla usando el proceso definido.",64,"Dpto Informatica :) :: Compresores Servicios::")
	ENDIF
