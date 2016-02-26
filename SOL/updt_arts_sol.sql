**********************************************************************************************************
**********************************************************************************************************
*** ACTUALIZACION DE ARTICULOS (updt_arts_sol)
**********************************************************************************************************
*** Se alimenta de la base de datos ART_A cada hora para actualizar costos y precios demas datos de articulos.
*** Actualiza las empresas SOLP_A y SOL_A asegurando la siguiente premisa
*** ART_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN 
**********************************************************************************************************
**********************************************************************************************************
*** Ultima actualización... Roy Febrero 2016
**********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()
tconnect4 = SQLCONECTAR()


*Roy: Getting and formating date and time
*NOTE: string >> fechaHora && datetime >> convert(datetime,fechaHora,131)
fechaHoy=date()
horaHoy=time()
fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

If  mensaje_sql(tconnect,0) <= 0
	Return .F.
Endif
If  mensaje_sql(tconnect1,0) <= 0
	Return .F.
Endif

MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"-->  INICIADO <--" +Chr(13)+"Este proceso puede tomar al rededor de un minuto.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*INSERT DE LINEA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.lin_art','v_linea')

do while !EOF('v_linea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.lin_art WHERE co_lin=?v_linea.co_lin','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOL_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	

	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.lin_art WHERE co_lin=?v_linea.co_lin','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [SOLP_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF
	
skip in v_linea
enddo



*************************************************************************
*INSERT DE SUBLINEA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.sub_lin','v_sublinea')

do while !EOF('v_sublinea')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.sub_lin WHERE co_subl=?v_sublinea.co_subl','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOL_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF
	
	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.sub_lin WHERE co_subl=?v_sublinea.co_subl','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [SOLP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

skip in v_sublinea
enddo



*************************************************************************
*INSERT DE CATEGORIA*
*************************************************************************
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.cat_art','v_cat')


do while !EOF('v_cat')
	*SOL_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.cat_art WHERE co_cat=?v_cat.co_cat','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOL_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOL_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOL_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*SOLP_A
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.cat_art WHERE co_cat=?v_cat.co_cat','v_RS')
		if EOF('v_RS')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [SOLP_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN SOLP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF


skip in v_cat
enddo

*************************************************************************
*INSERT DE ARTICULOS*
*************************************************************************
new_SOL=0
new_SOLP=0
updated_SOL=0
updated_SOLP=0

* UPDATING ONLY Those with STOCK on CS
tresult=sqlexec(tconnect,'SELECT * FROM ART_A.dbo.art WHERE stock_act>0','v_CS')

do while !EOF('v_CS')	

	*SOL_A PASO 1 GUARDAR NUEVO
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOL_A.dbo.art WHERE co_art=?v_CS.co_art','v_RS')
		if EOF('v_RS')
			
			ins="INSERT INTO [SOL_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_CS.co_art,?v_CS.art_des,?v_CS.co_lin,?v_CS.co_cat,?v_CS.co_subl,?v_CS.co_color,?v_CS.procedenci,"+;
			"'0000000001',?v_CS.uni_venta,?v_CS.suni_venta,?v_CS.tipo,?v_CS.tipo_imp,?v_CS.comentario,?v_CS.porc_cos,?v_CS.cos_merc,"+;
			"?v_CS.prec_vta1, ?v_CS.prec_vta2, ?v_CS.prec_vta3, ?v_CS.prec_vta4, ?v_CS.prec_vta5, ?v_CS.dis_cen, ?v_CS.tipo_cos, ?v_CS.campo1, ?v_CS.campo2, ?v_CS.campo8 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"SOL_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_CS.co_art)
			   Return .F.
			else
				new_SOL=new_SOL+1
				*MESSAGEBOX("SOL_A: SE INSERTO UN NUEVO ARTICULO: " + v_CS.co_art)	
			ENDIF
		ENDIF


		*SOL_A PASO 2 ACTUALIZAR

		IF (?v_CS.cos_merc > ?v_RS.cos_merc)
			**UPDATE RS=CS**
			costUpdate_query="UPDATE [SOL_A].[DBO].[ART] SET porc_cos=ART_A.porc_cos, cos_merc=ART_A.cos_merc, fec_cos_me=ART_A.fec_cos_me, tipo_cos=ART_A.tipo_cos, "+;
			"prec_vta1=ART_A.prec_vta1, prec_vta2=ART_A.prec_vta2, prec_vta3=ART_A.prec_vta3, prec_vta4=ART_A.prec_vta4, prec_vta5=ART_A.prec_vta5, "+;
			"fec_prec_v=ART_A.fec_prec_v, fec_prec_2=ART_A.fec_prec_2, fec_prec_3=ART_A.fec_prec_3, fec_prec_4=ART_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101) " +; 
			"FROM ART_A.dbo.art AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art " +;
			"WHERE co_art=?v_RS.co_art"

			tresult3=sqlexec(tconnect3,costUpdate_query)
			If mensaje_sql(tresult3,1,"Error: costUpdate_query @ SOL_A!") <= 0
				Return .F.
			else
				updated_SOL=updated_SOL+1
			ENDIF

			**Updating Descriptions annd DATES for their analysis **
			act="UPDATE [SOL_A].[DBO].[ART] SET art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
			"campo1=ART_A.campo1, campo2=ART_A.campo2, campo7=?fechaHora, campo8=ART_A.campo8 "+;
			"FROM ART_A.dbo.art AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art "

			tresult4=sqlexec(tconnect4,act)
			If mensaje_sql(tresult4,1,"Error UPDATE descriptions en SOL_A!") <= 0
				Return .F.
			ENDIF
		ELSE
			**INFORMING PEOPLE**
			IF (?v_RS.cos_merc = ?v_RS.ULT_COS_UN)
				**report_code =1**
				ins="INSERT INTO [SOL_A].[dbo].[aAa_updt_reports](CO_ART,ART_DES,report_code, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un)"+;
				" VALUES (?v_CS.co_art,?v_CS.art_des,'0', ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN) "
			ENDIF
			
			IF (?v_RS.cos_merc > ?v_RS.ULT_COS_UN)
				**report_code =2**
				ins="INSERT INTO [SOL_A].[dbo].[aAa_updt_reports](CO_ART,ART_DES,report_code, rs_cos_merc, cs_cos_merc, rs_ult_cos_un, cs_ult_cos_un)"+;
				" VALUES (?v_CS.co_art,?v_CS.art_des,'1', ?v_RS.cos_merc, ?v_CS.cos_merc, ?v_RS.ULT_COS_UN, ?v_CS.ULT_COS_UN) "
			ENDIF
		ENDIF




	*SOLP_A PASO 1 GUARDAR NUEVO
		tresult1=sqlexec(tconnect1,'SELECT * FROM SOLP_A.dbo.art WHERE co_art=?v_CS.co_art','v_RS')
		if EOF('v_RS')
			
			ins="INSERT INTO [SOLP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_CS.co_art,?v_CS.art_des,?v_CS.co_lin,?v_CS.co_cat,?v_CS.co_subl,?v_CS.co_color,?v_CS.procedenci,"+;
			"'0000000001',?v_CS.uni_venta,?v_CS.suni_venta,?v_CS.tipo,?v_CS.tipo_imp,?v_CS.comentario,?v_CS.porc_cos,?v_CS.cos_merc,"+;
			"?v_CS.prec_vta1, ?v_CS.prec_vta2, ?v_CS.prec_vta3, ?v_CS.prec_vta4, ?v_CS.prec_vta5, ?v_CS.dis_cen, ?v_CS.tipo_cos, ?v_CS.campo1, ?v_CS.campo2, ?v_CS.campo8 )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"SOLP_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_CS.co_art)
			   Return .F.
			else
				new_SOLP=new_SOLP+1
				*MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO ARTICULO: " + v_CS.co_art)	
			ENDIF
		ENDIF


		*SOLP_A PASO 2 ACTUALIZAR

		IF (?v_CS.cos_merc > ?v_RS.cos_merc)
			**UPDATE RS=CS**
			costUpdate_query="UPDATE [SOLP_A].[DBO].[ART] SET porc_cos=((( (SOL_A.prec_vta3/'1.2544')-SOL_A.cos_merc)/(SOL_A.prec_vta3/'1.2544'))*100 -1), "+;
			"prec_vta1=SOL_A.prec_vta1/'1.12', prec_vta2=SOL_A.prec_vta2/'1.12', prec_vta3=SOL_A.prec_vta3/'1.12', prec_vta4=SOL_A.prec_vta4/'1.12', prec_vta5=SOL_A.prec_vta5/'1.12', "+;
			"fec_prec_v=SOL_A.fec_prec_v, fec_prec_2=SOL_A.fec_prec_2, fec_prec_3=SOL_A.fec_prec_3, fec_prec_4=SOL_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101), " +; 
			"cos_merc=SOL_A.cos_merc, fec_cos_me=SOL_A.fec_cos_me, tipo_cos=SOL_A.tipo_cos, ULT_COS_UN=SOL_A.ULT_COS_UN, fec_ult_co=SOL_A.fec_ult_co "+;
			"FROM SOL_A.dbo.art "+; 
			"AS SOL_A inner join SOLP_A.dbo.art as SOLP_A on SOL_A.co_art=SOLP_A.co_art " +;
			"WHERE SOL_A.prec_vta3>0 AND co_art=?v_RS.co_art"
			*prec_vta3 evading /0 errors
	
			tresult3=sqlexec(tconnect3,costUpdate_query)
			If mensaje_sql(tresult3,1,"Error: costUpdate_query @ SOLP_A!") <= 0
				Return .F.
			else
				updated_SOLP=updated_SOLP+1
			ENDIF

			**Updating Descriptions annd DATES for their analysis **
			act="UPDATE [SOLP_A].[DBO].[ART] SET art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
			"campo1=ART_A.campo1, campo2=ART_A.campo2, campo7=?fechaHora, campo8=ART_A.campo8 "+;
			"FROM ART_A.dbo.art AS ART_A inner join SOLP_A.dbo.art as SOLP_A on ART_A.co_art=SOLP_A.co_art "

			tresult4=sqlexec(tconnect4,act)
			If mensaje_sql(tresult4,1,"Error UPDATE descriptions SOLP_A!") <= 0
				Return .F.
			ENDIF

skip in v_CS
enddo


InsertResultString="Articulos creados:"+Chr(13)+Chr(13)+"SOL_A: "+ALLTRIM(STR(new_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(new_SOLP))+Chr(13)+Chr(13)+Chr(13)+"Precios Actualizados:"+Chr(13)+"SOL_A: "+ALLTRIM(STR(updated_SOL))+Chr(13)+"SOLP_A: "+ALLTRIM(STR(updated_SOLP))
Messagebox(InsertResultString,64,"Resumen Proceso Actualizacion Precios")

MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde actualizar las Tablas locales en las empresas actualizadas.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*** LOG PARA CLIENTE*
*************************************************************************
*** ACTUALIZADO EL 26-05-2014
*** ACTUALIZA TARIBA LLEVANDO TODOS LOS DATOS DE LOS ARTICULOS DE BARRIO OBRERO...
*** ACTUALIZA SOLP_A = QUE TARIBA PERO LE QUITA EL IVA A LOS PRECIOS Y POR SUPUESTO AL MARGEN MINIMO...
*** USA CAMPOS 7 Y 8 PARA GUARDAR LA FECHA Y LA HORA DE ACTUALIZACION... TANTO EN SOLP_A COMO EN TARIBA
*** LOS ARTICULOS QUE NO TIENEN PRECIOS... NO SE ACTUALIZAN DE NINGUNA FORMA... POR ELLO PUEDE HABER ARTICULOS QUE NO TENGAN LA FECHA DE ACTUALIZACION...
*************************************************************************
*** ACTUALIZADO EL 15-01-15 		*
*** ACTUALIZA: SOL_A, SOLP_A, SOLP_A, CONAI_A				*
*** EL PROCESO CAMBIO DEBIDO A QUE SOL_A Y CONAI_A HACEN COMPRAS ENTONCES	*
*** ESTA ACTUALIZACION DE DATA SE HACE UNICAMENTE CUANDO  U *
*** ART_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN *
*** YA QUE SIEMPRE SE DEBEN MANTENER LOS PRECIOS/COSTOS MAS ALTOS *
*************************************************************************
*** Actualizado 18-01-15
*** Se alimenta de la base de datos ART_A cada hora para actualizar costos y precios demas datos de articulos.
*** Actualiza las empresas SOLP_A y SOL_A
*** Y otro que lo ejecutara Duvin. (muy parecido al que corria JeanCarlos)
*** Aqui se setean las horas en las cuales el proceso se ejecuto por Wender... esta informacion se repartira a las demas empresas para referencias... 
*** LA CONDICION DE PREC_VTA3 en el UPDATE NO ES NECESARIA LOGICAMENTE PERO ESTA PARA EVITAR ERRORES DEL PERSONAL DE COSERVICA
*** Si hay cambios en las descripciones las mismas no se haran sino se cambia un costo y se cumpla la condicion de que el costo sea mayor
*************************************************************************
*** UPDATE 10-02-15
*** SOLP_A se ACTUALIZA DE SOL_A
*************************************************************************
*** 02/26/16
*** La actualizacion para SOLP_A se hace quitando el IVA y tomando en cuenta que el prec_vta3>0 y ART_A.stock_act>
*** prec_vta3 > 0 para evitar /0
*** campo7			Actualización Hecha en Refrisol
*** campo8			Actualización Hecha en Compresores Servicios
*** fecha_precio5 	Actualización de precio porque CS.cos_merc> RS.cos_merc
*** Questions
*** y Not UPDATE cs.stock <= 0
