co_venF=TRIM(thisform.T_co_ven.value)
co_artF=TRIM(thisform.T_co_art.value)
canSolicitadaF=cast(thisform.T_canSolicitada.Value as int)

fechaHoy=date()

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif
	
**Consultando Articulos... 
	tresult_Art=sqlexec(tconnect,'select co_art,art_des,stock_act from art where co_art=?co_artF','V_ART')
	If  mensaje_sql(tresult_Art,"Error realizando select de art") <= 0
		Return .F.
	ENDIF

	co_art=V_ART.co_art
	art_des=V_ART.art_des
	stock_act=V_ART.stock_act
	
**Consultando Vendedores
	tresult_Ven=sqlexec(tconnect,'SELECT V.co_ven, V.ven_des FROM vendedor V where co_ven=?co_venF','V_VEN')
	If  mensaje_sql(tresult_Ven,"Error realizando select de Vendedores") <= 0
		Return .F.
	ENDIF

	co_ven=V_VEN.co_ven
	ven_des=trim(V_VEN.ven_des)
	
IF co_art!=co_artF
	messagebox(":.:ERROR CODIGO DE ARTICULO::",48,"Dpto Informatica :) :: Compresores Servicios::")
ELSE
	IF co_ven!=co_venF
		messagebox(":.:ERROR CODIGO DE VENDEDOR::",48,"Dpto Informatica :) :: Compresores Servicios::")
	ELSE		
		SQL_INSERT="INSERT INTO aAa_MercanciaFaltante VALUES (?co_art,?canSolicitadaF,?fechaHoy,?stock_act,?co_ven,NULL,?ven_des,NULL,NULL,NULL,?art_des)"
		tresult_InsertMF=sqlexec(tconnect,SQL_INSERT)
		If mensaje_sql(tresult_InsertMF,"Actualizado Satisfactoriamente","Error sql Insertando") <= 0
		   Return .F.
		else
			MESSAGEBOX("--> Registro de Mercancia Faltante <-- "+Chr(13)+Chr(13)+"Hola " + ven_des + Chr(13)+Chr(13)+ "Hemos registrado exitosamente la falta de " +STRTRAN(STR(canSolicitadaF),' ', '')+ " unidades de: "+Chr(13)+Chr(13)+ art_des +Chr(13)+"-->  Feliz Dia! <--",64,":.: Dpto Informatica :) Compresores Servicios :.:")
		ENDIF

	ENDIF
ENDIF

thisform.visible=false
thisform.close
thisform.release
	
*********************************************************************************************************************