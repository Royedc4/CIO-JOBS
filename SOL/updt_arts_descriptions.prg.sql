**********************************************************************************************************
*** ACTUALIZACION DE Descripcion de ARTICULOS (updt_arts_description)
**********************************************************************************************************
*** Requerimiento de Gerencias de ambas empresas
**********************************************************************************************************
*** Roy Enero 2015
**********************************************************************************************************

tconnect = SQLCONECTAR()
tconnect1 = SQLCONECTAR()
tconnect2 = SQLCONECTAR()
tconnect3 = SQLCONECTAR()

If  mensaje_sql(tconnect,0) <= 0
	Return .F.
Endif
If  mensaje_sql(tconnect1,0) <= 0
	Return .F.
Endif

MESSAGEBOX(":.:Proceso Actualizacion De Informacion :.: "+Chr(13)+"-->  INICIADO <--" +Chr(13)+"Este proceso puede tomar al rededor de un minuto.",64,"::Dpto Informatica :) Compresores Servicios::")

*************************************************************************
*ACTUALIZACION DE ARTICULOS*
*************************************************************************

*SOL_A
	act="update [SOL_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
	"campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOL_A.dbo.art as SOL_A on ART_A.co_art=SOL_A.co_art "

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOL_A!") <= 0
		Return .F.
	ENDIF

*SOLP_A
	act="update [SOLP_A].[DBO].[ART] set art_des=ART_A.art_des, comentario=ART_A.comentario, "+;
	"campo1=ART_A.campo1, campo2=ART_A.campo2 "+;
	"FROM ART_A.dbo.art "+; 
	"AS ART_A inner join SOLP_A.dbo.art as SOLP_A on ART_A.co_art=SOLP_A.co_art "

	tresult3=sqlexec(tconnect3,act)
	If mensaje_sql(tresult3,1,"Error UPDATE art en SOLP_A!") <= 0
		Return .F.
	ENDIF


MESSAGEBOX(":.:Proceso Actualizacion De Informacion :.: "+Chr(13)+"--> Completado Exitosamente <--" +Chr(13)+"Recuerde actualizar las Tablas locales en las empresas actualizadas.",64,"::Dpto Informatica :) Compresores Servicios::")

