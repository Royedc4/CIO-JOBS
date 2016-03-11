*******************************************************************************
*** BactualizarCostoProveedor
*** Ing. RoyCalderon -- 10 10 2015 
*** Calcula el costo en BsF desde costo en $
*** Calcula precio1 tomando en cuenta el costo anterior y el margen de ganancia 1
*** Escribe Dichos valores en directamente en el formulario de PROFIT para que sea guardado de forma tradicional
*******************************************************************************

PARAMETERS pForm1
*** Some variables
	costo=((thisform.Inacionalizacion.value/100*thisform.Icosto.value)+thisform.Icosto.value)*v_dolar.vfloat
	porcNacionalizacion=thisform.Inacionalizacion.value
	costoDolares=thisform.Icosto.value
	fechaHoy=date()
	horaHoy=time()
	fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif

tresult=sqlexec(tconnect,'select co_subl,mv1,flete,iva from aAa_margenesG where co_subl=?load_co_subl1','V_SUBLIN')
If  mensaje_sql(tresult,"Error realizando select") <= 0
	Return .F.
Endif
mv1=v_sublin.mv1

if(mv1=0)
	precio1=0
else
	precio1=((costo/flete)/mv1)*iva
endif

Thisform.visible=.f.
	_screen.activeform.pageframe1.page4.cos_prov1.value=costo
	_screen.activeform.pageframe1.page4.fec_cos_prov1.value=date()
	*Calculo de precio 1 basado en margen1
	_screen.activeform.pageframe1.page4.prec_vta11.value=precio1
	_screen.activeform.pageframe1.page4.fec_prec_v11.value=date()
	precio1=0

If (v_artDolares.costoDolares!=thisform.iCosto.value OR v_artDolares.porcNacionalizacion!=thisform.Inacionalizacion.value)
	sql_con="update aAa_artDolares SET costoDolares=?costoDolares, porcNacionalizacion=?porcNacionalizacion, modifiedOn=convert(datetime,?fechaHora,131) where co_art=?load_co_art"
	tresult1=sqlexec(tconnect,sql_con)
	If mensaje_sql(tresult1,":.: Proceso Actualizacion De Articulos en Divisas  --> ERROR!!!! :: Dpto Informatica :) :: Compresores Servicios :.:","Error sql Actualizando") <= 0
	   Return .F.
	else
		messagebox(":.: Proceso Actualizacion De Articulos en Divisas --> COMPLETADO :.:",64,"Dpto Informatica :) :: Compresores Servicios::")
	ENDIF	
Endif

Ruta="\\cssc-srv\CS.PROFIT\prg\art\"
thisform.Release
DO FORM Ruta+"p3_costodolares.SCX"

*******************************
*** FormCostoArt >> Init()	***
*** Ing. RoyCalderon 		***
*******************************

PARAMETERS pForma
*thisform.BactualizarCostoProveedor.click()
If serversql
	tconnect = SQLCONECTAR()
	If  mensaje_sql(tconnect,0) <= 0
		Return .F.
	Endif
Endif
*** Queries
tresult=sqlexec(tconnect,'select costoDolares,porcNacionalizacion,modifiedOn FROM aAa_artDolares where co_art=?load_co_art','v_artDolares')
*Only fucking way of validate if data came...
If	(TYPE("v_artDolares.costoDolares")=='N')
	thisform.Icosto.value=v_artDolares.costoDolares
	thisform.Inacionalizacion.value=v_artDolares.porcNacionalizacion
	thisform.lFechaCostoArt.caption="Actualizado al: "+TTOC(v_artDolares.modifiedOn)
EndIf
tresult=sqlexec(tconnect,'select vfloat, modifiedOn from aAa_Globals where name="dolar"','v_dolar')
*Only fucking way of validate if data came...
If	(TYPE("v_dolar.vfloat")=='N')
	thisform.lDolar.caption="Dolar Paralelo: "+STR(v_dolar.vfloat)+" BsF por c/$"
	thisform.lModifiedOn.caption="Actualizado al: "+TTOC(v_dolar.modifiedOn)
EndIf

***********************************
*** FormCostoArt *** Load() 	***
***********************************

PUBLIC load_ult_cos_un,load_por_cos_adic,load_marg_gan11,load_co_subl1,load_co_art
**ultimo costo**
load_ult_cos_un=_screen.activeform.pageframe1.page4.ult_cos_un1.value
**margen minimo**
load_por_cos_adic=_screen.activeform.pageframe1.page4.por_cos_adic.value
**codigo de sub-linea**
load_co_subl1=_screen.activeform.pageframe1.page1.co_subl1.value
**codigo del articulo
load_co_art=_screen.activeform.pageframe1.page1.co_art1.value

***********************************
*** BactualizarDolar *** click()***
***********************************

Ruta="\\cssc-srv\CS.PROFIT\prg\art\"
thisform.Release
DO FORM Ruta+"p3_globales.SCX"
