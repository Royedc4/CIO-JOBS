***********************************************************************************************************
*** ACTUALIZACION DE CLIENTES (updt_clis)																***
***********************************************************************************************************
*** Distribuye los datos de la empresa Matriz (SOL_A) a otras empresas									***
*** Con el fin de actualizar los clientes y demas tablas de los clientes asociados                      ***
*** Actualiza la empresas SOLP_A																		***
***********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()
tconnect4 = SQLCONECTAR()


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

MESSAGEBOX(":.:Proceso Actualizacion de Clientes :.: "+Chr(13)+"-->  INICIADO <--" +Chr(13)+"Este proceso puede tomar al rededor de un minuto.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*INSERT TIPO DE CLIENTE*
*************************************************************************

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.tipo_cli','v_tipo_cli')


do while !EOF('v_tipo_cli')

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.tipo_cli where tip_cli=?v_tipo_cli.tip_cli','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO TIPO DE CLIENTE:" + v_tipo_cli.tip_cli)
			ins="INSERT INTO [SOLP_A].[dbo].[tipo_cli] (tip_cli,des_tipo,precio_a) VALUES (?v_tipo_cli.tip_cli,?v_tipo_cli.des_tipo,?v_tipo_cli.precio_a)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos en SOLP_A, Tipo de Cliente., INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_tipo_cli
enddo

*************************************************************************
*INSERT ZONA DEL CLIENTE*
*************************************************************************

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.zona','v_zona')


do while !EOF('v_zona')

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.zona where co_zon=?v_zona.co_zon','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UNA NUEVA ZONA DE CLIENTE:" + v_zona.co_zon)
			ins="INSERT INTO [SOLP_A].[dbo].[zona] (co_zon,zon_des) VALUES (?v_zona.co_zon,?v_zona.zon_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos en SOLP_A Zona del Cliente., INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_zona
ENDDO



*************************************************************************
*INSERT SEGMENTO DEL CLIENTE*
*************************************************************************

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.segmento','v_segmento')


do while !EOF('v_segmento')

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.segmento where co_seg=?v_segmento.co_seg','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO SEGMENTO DE CLIENTE:" + v_segmento.co_seg)
			ins="INSERT INTO [SOLP_A].[dbo].[segmento] (co_seg,seg_des) VALUES (?v_segmento.co_seg,?v_segmento.seg_des)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos en SOLP_A Segmento del Cliente., INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_segmento
enddo




*************************************************************************
*INSERT VENDEDOR DEL CLIENTE*
*************************************************************************

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.vendedor','v_vendedor')


do while !EOF('v_vendedor')

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.vendedor where co_ven=?v_vendedor.co_ven','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVO VENDEDOR:" + v_vendedor.co_ven)
			ins="INSERT INTO [SOLP_A].[dbo].[vendedor] (co_ven,tipo,ven_des,cedula,direc1,direc2,telefonos,fecha_reg,condic,comision,comen,fun_cob,fun_ven,comisionv,fac_ult_ve,fec_ult_ve,net_ult_ve,cli_ult_ve) "+;
			    " VALUES (?v_vendedor.co_ven,?v_vendedor.tipo,?v_vendedor.ven_des,?v_vendedor.cedula,?v_vendedor.direc1,?v_vendedor.direc2,?v_vendedor.telefonos,?v_vendedor.fecha_reg,?v_vendedor.condic,"+;
			    " ?v_vendedor.comision,?v_vendedor.comen,?v_vendedor.fun_cob,?v_vendedor.fun_ven,?v_vendedor.comisionv,?v_vendedor.fac_ult_ve,?v_vendedor.fec_ult_ve,?v_vendedor.net_ult_ve,?v_vendedor.cli_ult_ve)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos en SOLP_A Vendedor., INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_vendedor
enddo




*************************************************************************
*INSERT CTA INGRESO/EGRESO*
*************************************************************************

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.cta_ingr','v_cta_ingr')


do while !EOF('v_cta_ingr')

	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.cta_ingr where co_ingr=?v_cta_ingr.co_ingr','v_resultado')
		if EOF('v_resultado')
			MESSAGEBOX("SOLP_A: SE INSERTO UN NUEVA CUENTA DE INGRESO/EGRESO:" + v_cta_ingr.co_ingr)
			ins="INSERT INTO [SOLP_A].[dbo].[cta_ingr] (co_ingr,descrip,co_islr) "+;
			    " VALUES (?v_cta_ingr.co_ingr,?v_cta_ingr.descrip,?v_cta_ingr.co_islr)"
			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Error sql Insertando Datos en SOLP_A Cta. Ingreso/Egreso., INFORMAR AL DPTO INFORMATICA") <= 0
			  Return .F.
			ENDIF
		ENDIF

skip in v_cta_ingr
enddo





*************************************************************************
*INSERT DE CLIENTES*
*************************************************************************


conCOSEP=0

tresult=sqlexec(tconnect,'select * from SOL_A.dbo.Clientes','v_CT')

do while !EOF('v_CT')

*!*	*SOLP_A
		tresult1=sqlexec(tconnect1,'select * from SOLP_A.dbo.Clientes where co_cli=?v_CT.co_cli','v_resultado')
		if EOF('v_resultado')

			ins="INSERT INTO [SOLP_A].[dbo].[Clientes] (co_cli,tipo,cli_des,direc1,direc2,telefonos,fax,inactivo,comentario,respons,fecha_reg,puntaje,fac_ult_ve,fec_ult_ve,net_ult_ve,mont_cre, "+;				
				"plaz_pag,desc_ppago,co_zon,co_seg,co_ven,desc_glob,horar_caja,frecu_vist,lunes,martes,miercoles,jueves,viernes,sabado,domingo,dir_ent2,tipo_iva,iva,rif, "+;
				"contribu,nit,email,co_ingr,juridico,tipo_adi,matriz,co_tab,tipo_per,serialp,estado,co_pais,ciudad,zip,sincredito,porc_esp,contribu_e)"+;				
			" VALUES (?v_CT.co_cli,?v_CT.tipo,?v_CT.cli_des,?v_CT.direc1,?v_CT.direc2,?v_CT.telefonos,?v_CT.fax,?v_CT.inactivo,?v_CT.comentario,?v_CT.respons,?v_CT.fecha_reg,?v_CT.puntaje,?v_CT.fac_ult_ve,?v_CT.fec_ult_ve,?v_CT.net_ult_ve,?v_CT.mont_cre, "+;
				"?v_CT.plaz_pag,?v_CT.desc_ppago,?v_CT.co_zon,?v_CT.co_seg,?v_CT.co_ven,?v_CT.desc_glob,?v_CT.horar_caja,?v_CT.frecu_vist,?v_CT.lunes,?v_CT.martes,?v_CT.miercoles,?v_CT.jueves,?v_CT.viernes,?v_CT.sabado,?v_CT.domingo,?v_CT.dir_ent2,?v_CT.tipo_iva,"+;
				"?v_CT.iva,?v_CT.rif,?v_CT.contribu,?v_CT.nit,?v_CT.email,?v_CT.co_ingr,?v_CT.juridico,?v_CT.tipo_adi,?v_CT.matriz,?v_CT.co_tab,?v_CT.tipo_per,?v_CT.serialp,?v_CT.estado,?v_CT.co_pais,?v_CT.ciudad,?v_CT.zip,?v_CT.sincredito,?v_CT.porc_esp,?v_CT.contribu_e)"

			tresult2=sqlexec(tconnect2,ins)
			If mensaje_sql(tresult2,1,"Empresa: SOLP_A Error sql Insertando Clientes., INFORMAR AL DPTO INFORMATICA") <= 0
				messagebox(v_CT.co_cli)
			   Return .F.
			else
				conCOSEP=conCOSEP+1
			ENDIF
		ENDIF	

skip in v_CT
enddo

InsertResultString="Se han insertado la siguiente cantidad de Clientes en las empresas."+Chr(13)+Chr(13)+"SOLP_A: "+ALLTRIM(STR(conCOSEP))
Messagebox(InsertResultString,64,"Insercion de Clientes Nuevos.")



*!*	*************************************************************************
*!*	*ACTUALIZACION DE CLIENTES*
*!*	*************************************************************************
	
* SOLP_A	

act="update [SOLP_A].[DBO].[Clientes] set "+;
"tipo=SOL_A.tipo,cli_des=SOL_A.cli_des,direc1=SOL_A.direc1,direc2=SOL_A.direc2,telefonos=SOL_A.telefonos,fax=SOL_A.fax,inactivo=SOL_A.inactivo, "+;
"comentario=SOL_A.comentario,respons=SOL_A.respons,fecha_reg=SOL_A.fecha_reg,puntaje=SOL_A.puntaje,fac_ult_ve=SOL_A.fac_ult_ve,fec_ult_ve=SOL_A.fec_ult_ve, "+;
"net_ult_ve=SOL_A.net_ult_ve,mont_cre=SOL_A.mont_cre,plaz_pag=SOL_A.plaz_pag,desc_ppago=SOL_A.desc_ppago,co_zon=SOL_A.co_zon,co_seg=SOL_A.co_seg, "+;
"co_ven=SOL_A.co_ven,desc_glob=SOL_A.desc_glob,horar_caja=SOL_A.horar_caja,frecu_vist=SOL_A.frecu_vist,lunes=SOL_A.lunes,martes=SOL_A.martes, "+;
"miercoles=SOL_A.miercoles,jueves=SOL_A.jueves,viernes=SOL_A.viernes,sabado=SOL_A.sabado,domingo=SOL_A.domingo,dir_ent2=SOL_A.dir_ent2,tipo_iva=SOL_A.tipo_iva, "+;
"iva=SOL_A.iva,rif=SOL_A.rif,contribu=SOL_A.contribu,nit=SOL_A.contribu,email=SOL_A.email,co_ingr=SOL_A.co_ingr,juridico=SOL_A.juridico,tipo_adi=SOL_A.tipo_adi, "+;
"matriz=SOL_A.matriz,co_tab=SOL_A.co_tab,tipo_per=SOL_A.tipo_per,serialp=SOL_A.serialp,estado=SOL_A.estado,co_pais=SOL_A.co_pais,ciudad=SOL_A.ciudad, "+;
"zip=SOL_A.zip,sincredito=SOL_A.sincredito,porc_esp=SOL_A.porc_esp,contribu_e=SOL_A.contribu "+;
"FROM SOL_A.dbo.Clientes as SOL_A INNER JOIN [SOLP_A].[DBO].[Clientes] as SOLP_A on SOL_A.co_cli=SOLP_A.co_cli "


	tresult4=sqlexec(tconnect4,act)
	If mensaje_sql(tresult4,1,"Error UPDATE Clientes en SOLP_A.") <= 0
		Return .F.
	ENDIF




MESSAGEBOX(":.:Proceso Actualizacion de Clientes :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde actualizar las Tablas locales en las empresas actualizadas.",64,"::Dpto Informatica :) Compresores Servicios::")