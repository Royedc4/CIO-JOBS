*******************************************************************************
*** actualizarDolar *** Click()
*** Ing. RoyCalderon -- 10 10 2015 
*** Actualiza el valor global del dolar para estos procesos.
*******************************************************************************

vafloat=(thisform.dolarParalelo.value)
fechaHoy=date()
horaHoy=time()
fechaHora=DATETIME(YEAR(fechaHoy), MONTH(fechaHoy), DAY(fechaHoy), VAL(LEFT(horaHoy, 2)), VAL(SUBS(horaHoy, 4, 2)), VAL(RIGHT(horaHoy, 2)))

sql_con="update aAa_Globals SET vfloat=?vafloat, modifiedOn=convert(datetime,?fechaHora,131) where name='dolar'"

tresult1=sqlexec(tconnect,sql_con)
If mensaje_sql(tresult1,":.: Proceso Actualizacion De Dolar  --> ERROR!!!! :: Dpto Informatica :) :: Compresores Servicios :.:","Error sql Actualizando") <= 0
   Return .F.
else
	messagebox(":.: Proceso Actualizacion De Dolar  --> COMPLETADO :.:",64,"Dpto Informatica :) :: Compresores Servicios::")
	Ruta="\\cssc-srv\CS.PROFIT\prg\art\"
	thisform.Release
	DO FORM Ruta+"p3_costodolares.SCX"
ENDIF