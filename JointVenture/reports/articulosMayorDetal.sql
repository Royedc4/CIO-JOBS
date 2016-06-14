PROCEDURE BeforeOpenTables
set deleted on
do open_dat WITH THIS

return

ENDPROC
PROCEDURE Init
*SET DATE TO british
SET CENTURY ON
SET datasession to

&& Articulos con todos los costos

tnom_rep =UPPER(ALLTRIM(tnombre_report))

DO tit_rep WITH 8

LOCAL llcontinue
ttabla = "art."
tfrom  = "art"
IF rnumero = 1            && para que el mismo reporte se pueda use para imprimir segun varios ordenes por codigo por descripcion
	orden  = "Art.co_art"
ELSE
	orden  = "Art.art_des"
ENDIF

ttabla2 = 'prov.'
tfrom2  = 'prov'
ttabla3 = 'lin_art.'
tfrom3  = 'lin_art'
ttabla4 = 'cat_art.'
tfrom4  = 'cat_art'
ttabla5 = 'sub_lin.'
tfrom5  = 'sub_lin'

IF serversql  && LPZ 02/08
***************************  Conexion *****************************************
	tconnect = SQLCONECTAR()
	IF  mensaje_sql(tconnect,0) <= 0
		RETURN .F.
	ENDIF

	tca1 = "&ttabla.co_art, &ttabla.art_des, &ttabla2.prov_des, &ttabla3.lin_des, &ttabla4.cat_des, &ttabla5.subl_des "
	tfr1 = "&tfrom,&tfrom2,&tfrom3,&tfrom4,&tfrom5 "
	twh1 = "&ttabla.anulado = 0 AND &ttabla.co_prov = &ttabla2.co_prov "
	twh2 = "AND &ttabla.co_lin  = &ttabla3.co_lin AND &ttabla.co_cat  = &ttabla4.co_cat "
	twh3 = "AND &ttabla.co_subl = &ttabla5.co_subl AND &ttabla.co_lin  = &ttabla5.co_lin "
	twh4 = "AND &ttabla.co_art   BETWEEN ?tdesde[1] AND ?thasta[1]   AND &ttabla.art_des    BETWEEN ?tdesde[2] AND ?thasta[2] "
	twh5 = "AND &ttabla.co_lin     BETWEEN ?tdesde[3] AND ?thasta[3] AND &ttabla.co_cat     BETWEEN ?tdesde[4] AND ?thasta[4] "
	twh6 = "AND &ttabla.co_subl    BETWEEN ?tdesde[5] AND ?thasta[5] AND &ttabla.co_color   BETWEEN ?tdesde[6] AND ?thasta[6] "
	twh7 = "AND &ttabla.co_prov    BETWEEN ?tdesde[7] AND ?thasta[7] "
	tor1 = "&orden"

	*tresult=sqlexec(tconnect,'SELECT '+tca1+' FROM '+tfr1+' WHERE '+twh1+twh2+twh3+twh4+twh5+twh6+twh7+' ORDER BY '+tor1,'vreportes')
		
		***B***
		**ROY**
		*******
		select_unique 	= "SELECT A.co_art, A.art_des, SUM(stM.stockMayor) as stockMayor, SUM(stD.stockDetal)  as stockDetal "
		from_unique		= " FROM ART A "
		join1			= " JOIN	(	SELECT	stM.co_art, SUM(stM.stock_act) as stockMayor FROM st_almac stM		WHERE	stM.co_alma IN ('PGVM','PPGM','PPMY')					GROUP BY stM.co_art	) as stM		ON (stM.co_art=A.co_art) "
		join2			= " JOIN	(	SELECT	stD.co_art, SUM(stD.stock_act) as stockDetal FROM st_almac stD		WHERE	stD.co_alma IN ('PPDT','PPEX','PPGD','PPGV','TBDT')		GROUP BY co_art		) as stD		ON (stD.co_art=stM.co_art)	"
		where_unique 	= "	stD.stockDetal=0 AND stM.stockMayor>0 "
		group_unique	= " GROUP BY A.co_art, A.art_des "
		*De Filtros
		ttabla = "A."
		rtwh1 = "AND &ttabla.anulado = 0 "
		twh4 = "AND &ttabla.co_art   BETWEEN ?tdesde[1] AND ?thasta[1]   AND &ttabla.art_des    BETWEEN ?tdesde[2] AND ?thasta[2] "
		twh5 = "AND &ttabla.co_lin     BETWEEN ?tdesde[3] AND ?thasta[3] AND &ttabla.co_cat     BETWEEN ?tdesde[4] AND ?thasta[4] "
		twh6 = "AND &ttabla.co_subl    BETWEEN ?tdesde[5] AND ?thasta[5] AND &ttabla.co_color   BETWEEN ?tdesde[6] AND ?thasta[6] "
		tresult=sqlexec(tconnect, select_unique + from_unique + join1 + join2 + ' WHERE ' + where_unique + rtwh1 + twh4+twh5+twh6 + group_unique, 'vreportes')
		***E***
		**ROY**
		*******

	&&mensaje_sql(tresult,1)
	IF  mensaje_sql(tresult,1) <= 0
		RETURN .F.
	ENDIF

llcontinue = .T.

RETURN llcontinue

ENDPROC
