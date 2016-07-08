***********************************************************************************************************
*** ACTUALIZACION DE ARTICULOS (updt_arts)                                                              ***
***********************************************************************************************************
*** Distribuye los datos de la empresa Matriz (COSER_A) a otras empresas                                ***
*** Con el fin de actualizar costos y precios demas datos de articulos.                                 ***
*** Actualiza las empresas ART_A CONAI_A y COSEP_A asegurando la siguiente premisa                      ***
*** COSER_A.ART.COS_MERC > EMPRESAXXX.ART.ULT_COS_UN                                                    ***
***********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()
tconnect4 = SQLCONECTAR()

*Roy DATE*
fechaHoy=date()
horaHoy=time()
fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))
*String >> fechaHora y datetime >> convert(datetime,fechaHora,131)


If  mensaje_sql(tconnect,0) <= 0e
	Return .F.
Endif
If  mensaje_sql(tconnect1,0) <= 0
	Return .F.
Endif

MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"-->  INICIADO <--" +Chr(13)+"Este proceso puede tomar al rededor de un minuto.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*INSERT DE COLOR*
*************************************************************************

tresult=sqlexec(tconnect,'select * from COSER_A.dbo.colores','v_color')


do while !EOF('v_color')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UN NUEVO COLOR:" + v_color.co_col)
			ins="INSERT INTO [ART_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_color.co_col)
			ins="INSERT INTO [COSEP_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_color.co_col)
			ins="INSERT INTO [CONAI_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*FRIOS_A
		tresult1=sqlexec(tconnect1,'select * from FRIOS_A.dbo.colores where co_col=?v_color.co_col','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("FRIOS_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_color.co_col)
			ins="INSERT INTO [FRIOS_A].[dbo].[colores] (co_col,des_col) VALUES (?v_color.co_col,?v_color.des_col)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN FRIOS_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF



skip in v_color
enddo

*************************************************************************
*INSERT DE LINEA*
*************************************************************************

tresult=sqlexec(tconnect,'select * from COSER_A.dbo.lin_art','v_linea')

do while !EOF('v_linea')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [ART_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [COSEP_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF


	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [CONAI_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF

	*FRIOS_A
		tresult1=sqlexec(tconnect1,'select * from FRIOS_A.dbo.lin_art where co_lin=?v_linea.co_lin','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("FRIOS_A: SE INSERTO UNA NUEVA LINEA: "+Chr(13)+ v_linea.co_lin)
			ins="INSERT INTO [FRIOS_A].[dbo].[lin_art] (co_lin,lin_des,campo4) VALUES (?v_linea.co_lin,?v_linea.lin_des,'300')"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN FRIOS_A, INFORMAR AL DPTO INFORMATICA") <= 0
			   Return .F.
			ENDIF
		ENDIF

skip in v_linea
enddo

*************************************************************************
*INSERT DE SUBLINEA*
*************************************************************************

tresult=sqlexec(tconnect,'select * from COSER_A.dbo.sub_lin','v_sublinea')

do while !EOF('v_sublinea')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [ART_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [COSEP_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF


	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [CONAI_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

	*FRIOS_A
		tresult1=sqlexec(tconnect1,'select * from FRIOS_A.dbo.sub_lin where co_subl=?v_sublinea.co_subl','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("FRIOS_A: SE INSERTO UNA NUEVA SUBLINEA: "+Chr(13)+ v_sublinea.co_subl)
			ins="INSERT INTO [FRIOS_A].[dbo].[sub_lin] (co_subl,subl_des,co_lin) VALUES (?v_sublinea.co_subl,?v_sublinea.subl_des,?v_sublinea.co_lin)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN FRIOS_A , INFORMAR AL DPTO INFORMATICA") <= 0
			 Return .F.
			ENDIF
		ENDIF

skip in v_sublinea
enddo



*************************************************************************
*INSERT DE CATEGORIA*
*************************************************************************

tresult=sqlexec(tconnect,'select * from COSER_A.dbo.cat_art','v_cat')

do while !EOF('v_cat')
	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("ART_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [ART_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN ART_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("COSEP_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [COSEP_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN COSEP_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("CONAI_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [CONAI_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN CONAI_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

	*FRIOS_A
		tresult1=sqlexec(tconnect1,'select * from FRIOS_A.dbo.cat_art where co_cat=?v_cat.co_cat','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("FRIOS_A: SE INSERTO UNA NUEVA CATEGORIA:" + v_cat.co_cat)
			ins="INSERT INTO [FRIOS_A].[dbo].[cat_art] (co_cat,cat_des) VALUES (?v_cat.co_cat,?v_cat.cat_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos EN FRIOS_A, INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_cat
enddo

*************************************************************************
*INSERT DE ARTICULOS*
*************************************************************************

con=0
conCOSEP=0
conCONAI=0
conFRIOS=0

tresult=sqlexec(tconnect,'select * from COSER_A.dbo.art','v_SC')

do while !EOF('v_SC')

	*ART_A
		tresult1=sqlexec(tconnect1,'select * from ART_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')

			ins="INSERT INTO [ART_A].[dbo].[art](STOCK_ACT, CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.stock_act, ?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1,?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"ART_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				con=con+1
				*MESSAGEBOX("ART_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)
			ENDIF
		ENDIF

	*COSEP_A
		tresult1=sqlexec(tconnect1,'select * from COSEP_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')

			ins="INSERT INTO [COSEP_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1, ?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Empresa: COSEP_A Error sql Insertando ART, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conCOSEP=conCOSEP+1
				*MESSAGEBOX("COSEP_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)
			ENDIF
		ENDIF

	*CONAI_A
		tresult1=sqlexec(tconnect1,'select * from CONAI_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')

			ins="INSERT INTO [CONAI_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1, ?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"CONAI_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conCONAI=conCONAI+1
				*MESSAGEBOX("CONAI_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)
			ENDIF
		ENDIF

	*FRIOS_A
		tresult1=sqlexec(tconnect1,'select * from FRIOS_A.dbo.art where co_art=?v_SC.co_art','v_resultado')
		if EOF('v_resultado')

			ins="INSERT INTO [FRIOS_A].[dbo].[art](CO_ART,ART_DES,CO_LIN,CO_CAT,CO_SUBL,CO_COLOR,PROCEDENCI,CO_PROV,UNI_VENTA,"+;
			" SUNI_VENTA,TIPO,TIPO_IMP,COMENTARIO,PORC_COS,cos_merc,prec_vta1,prec_vta2,prec_vta3,prec_vta4,prec_vta5, dis_cen, tipo_cos, campo1, campo2, campo8)"+;
			" VALUES (?v_SC.co_art,?v_SC.art_des,?v_SC.co_lin,?v_SC.co_cat,?v_SC.co_subl,?v_SC.co_color,?v_SC.procedenci,"+;
			"'0000000001',?v_SC.uni_venta,?v_SC.suni_venta,?v_SC.tipo,?v_SC.tipo_imp,?v_SC.comentario,?v_SC.porc_cos,?v_SC.cos_merc,"+;
			"?v_SC.prec_vta1, ?v_SC.prec_vta2, ?v_SC.prec_vta3, ?v_SC.prec_vta4, ?v_SC.prec_vta5, ?v_SC.dis_cen, ?v_SC.tipo_cos, ?v_SC.campo1, ?v_SC.campo2, ?fechaHora )"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"FRIOS_A Error sql Insertando ART 1, INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_SC.co_art)
			   Return .F.
			else
				conFRIOS=conFRIOS+1
				*MESSAGEBOX("FRIOS_A: SE INSERTO UN NUEVO ARTICULO: " + v_SC.co_art)
			ENDIF
		ENDIF
skip in v_SC
enddo

InsertResultString="Se han insertado la siguiente cantidad de articulos en las empresas."+Chr(13)+Chr(13)+"ART_A: "+ALLTRIM(STR(con))+Chr(13)+"COSEP_A: "+ALLTRIM(STR(conCOSEP))+Chr(13)+"CONAI_A: "+ALLTRIM(STR(conCONAI))+Chr(13)+"FRIOS_A: "+ALLTRIM(STR(conFRIOS))
Messagebox(InsertResultString,64,"Insercion de Articulos Nuevos")

*************************************************************************
*ACTUALIZACION DE ARTICULOS*
*************************************************************************

*La actualizacion para ART_A es completa... Una replica de COSER_A
*La actualizacion para COSEP_A se hace quitando el IVA y tomando en cuenta que el prec_vta3>0 y COSER_A.stock_act>0
*La actualizacion para CONAI_A se hace siempre y cuando el cos_merc de COSER_A > CONAI_A y COSER_A.stock_act>0
*La actualizacion para CONAI_A se hace siempre y cuando el cos_merc de COSER_A > CONAI_A y COSER_A.stock_act>0



	*ART_A
	act="update [ART_A].[DBO].[ART] set porc_cos=COSER_A.porc_cos, "+;
	"stock_act=COSER_A.stock_act, prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101),  " +;
	"fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, ULT_COS_UN=COSER_A.ULT_COS_UN, fec_ult_co=COSER_A.fec_ult_co "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join ART_A.dbo.art as ART_A on COSER_A.co_art=ART_A.co_art "

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en ART_A!") <= 0
		Return .F.
	ENDIF

	act="update [ART_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, "+;
	"campo1=COSER_A.campo1, campo2=COSER_A.campo2, campo8=?fechaHora "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join ART_A.dbo.art as ART_A on COSER_A.co_art=ART_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en ART_A!") <= 0
		Return .F.
	ENDIF

	*COSEP_A
	act="update [COSEP_A].[DBO].[ART] set porc_cos=((( (COSER_A.prec_vta3/'1.12')-COSER_A.cos_merc)/(COSER_A.prec_vta3/'1.12'))*100 -1), "+;
	"prec_vta1=COSER_A.prec_vta1/'1.12', prec_vta2=COSER_A.prec_vta2/'1.12', prec_vta3=COSER_A.prec_vta3/'1.12', prec_vta4=COSER_A.prec_vta4/'1.12', prec_vta5=COSER_A.prec_vta5/'1.12', "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101),  " +;
	"fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen, ULT_COS_UN=COSER_A.ULT_COS_UN, fec_ult_co=COSER_A.fec_ult_co "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join COSEP_A.dbo.art as COSEP_A on COSER_A.co_art=COSEP_A.co_art " +;
	"WHERE COSER_A.prec_vta3>0"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en COSEP_A!") <= 0
		Return .F.
	ENDIF

	act="update [COSEP_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, "+;
	"campo1=COSER_A.campo1, campo2=COSER_A.campo2, campo8=?fechaHora "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join COSEP_A.dbo.art as COSEP_A on COSER_A.co_art=COSEP_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en COSEP_A!") <= 0
		Return .F.
	ENDIF


	*CONAI_A
	act="update [CONAI_A].[DBO].[ART] set porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101), " +;
	"fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join CONAI_A.dbo.art as CONAI_A on COSER_A.co_art=CONAI_A.co_art " +;
	"WHERE COSER_A.stock_act> 0 AND (COSER_A.cos_merc > CONAI_A.cos_merc)"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en CONAI_A!") <= 0
		Return .F.
	ENDIF

	act="update [CONAI_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, "+;
	"campo1=COSER_A.campo1, campo2=COSER_A.campo2, campo8=?fechaHora, ULT_COS_UN=COSER_A.ULT_COS_UN, fec_ult_co=COSER_A.fec_ult_co "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join CONAI_A.dbo.art as CONAI_A on COSER_A.co_art=CONAI_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en CONAI_A!") <= 0
		Return .F.
	ENDIF

	*FRIOS_A
	act="update [FRIOS_A].[DBO].[ART] set porc_cos=COSER_A.porc_cos, "+;
	"prec_vta1=COSER_A.prec_vta1, prec_vta2=COSER_A.prec_vta2, prec_vta3=COSER_A.prec_vta3, prec_vta4=COSER_A.prec_vta4, prec_vta5=COSER_A.prec_vta5, "+;
	"fec_prec_v=COSER_A.fec_prec_v, fec_prec_2=COSER_A.fec_prec_2, fec_prec_3=COSER_A.fec_prec_3, fec_prec_4=COSER_A.fec_prec_4, fec_prec_5=convert(smalldatetime,?fechaHoy,101), " +;
	"fec_cos_p2=COSER_A.fec_cos_p2, cos_merc=COSER_A.cos_merc, fec_cos_me=COSER_A.fec_cos_me, tipo_cos=COSER_A.tipo_cos, dis_cen=COSER_A.dis_cen "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join FRIOS_A.dbo.art as FRIOS_A on COSER_A.co_art=FRIOS_A.co_art " +;
	"WHERE COSER_A.stock_act> 0 AND (COSER_A.cos_merc > FRIOS_A.cos_merc)"

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en FRIOS_A!") <= 0
		Return .F.
	ENDIF

	act="update [FRIOS_A].[DBO].[ART] set art_des=COSER_A.art_des, comentario=COSER_A.comentario, "+;
	"campo1=COSER_A.campo1, campo2=COSER_A.campo2, campo8=?fechaHora, ULT_COS_UN=COSER_A.ULT_COS_UN, fec_ult_co=COSER_A.fec_ult_co "+;
	"FROM COSER_A.dbo.art "+;
	"AS COSER_A inner join FRIOS_A.dbo.art as FRIOS_A on COSER_A.co_art=FRIOS_A.co_art "

	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE descriptions en FRIOS_A!") <= 0
		Return .F.
	ENDIF



MESSAGEBOX(":.:Proceso Actualizacion De Precios :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde actualizar las Tablas locales en las empresas actualizadas.",64,"::Dpto Informatica :) Compresores Servicios::")