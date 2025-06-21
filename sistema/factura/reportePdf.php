<?php
	$subtotal 	= 0;
	$iva 	 	= 0;
	$impuesto 	= 0;
	$tl_sniva   = 0;
	$total 		= 0;
	$impuesto = round($subtotal * ($iva / 100), 2);
$tl_sniva = round($subtotal - $impuesto, 2);
$total = $tl_sniva + $impuesto;
 //print_r($configuracion); ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Venta</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="page_pdf">
	<table id="factura_head">
		<tr>
			<td class="logo_factura">
				<div>
					<?php 
					$imagePath = 'img/' . $configuracion['foto'];
					
					// Verificar si el archivo existe
					if (file_exists($imagePath)) {
						try {
							$imageData = base64_encode(file_get_contents($imagePath));
							?>
							<img style="width: 200px;" src="data:image/jpeg;base64,<?php echo $imageData; ?>" alt="Logo">
							<?php
						} catch (Exception $e) {
							// Si hay error al leer la imagen, mostrar texto alternativo
							echo "<span>Logo empresa</span>";
						}
					} else {
						// Si no existe el archivo, mostrar texto alternativo
						echo "<span>Logo empresa</span>";
					}
					?>
				</div>
			</td>
			<td class="info_empresa">
				<?php
					if($result_conf> 0){
						$moned = $configuracion['moneda'];
					}
				 ?>
				<div>

					<span class="h2"><?php echo strtoupper($configuracion['nombre']); ?></span>
					<p><?php echo $configuracion['razon_social']; ?></p>
					<p><?php echo $configuracion['direccion']; ?></p>
					<p>RUC: <?php echo $configuracion['ruc']; ?></p>
					<p>Teléfono: <?php echo $configuracion['telefono']; ?></p>
					<p>Email: <?php echo $configuracion['email']; ?></p>
				</div>
			</td>
			<td class="info_factura">

			</td>
		</tr>
		
	</table>

	<table id="factura_detalle">
			<thead>
				<tr>
					<th>No.</th>
					<th>Fecha / Hora</th>
					<th>Cliente</th>
					<th>Vendedor</th>
					<th>Estado</th>
					<th class="">Total Venta</th>
				</tr>
			</thead>
			<tbody id="detalle_productos">
				<?php

				if ($result > 0) {
					$ventas_totales = 0;
					while ($data = mysqli_fetch_array($query)) {
						if ($data['status'] == 1) {
							$estatus = '<span class="pagada">Pagada</span>';
						}elseif ($data['status'] == 4) {
							$estatus = '<span class="credito">Abono</span>';
						}

						 // Validar y convertir valores
						$totalfact = !empty($data["totalventa"]) ? floatval($data["totalventa"]) : 0;
						$abono = !empty($data["abono"]) ? floatval($data["abono"]) : 0;

						// Formatear datos con validación
						$nofactura = isset($data["noventa"]) ? $data["noventa"] : '';
						$fecha = isset($data["fecha"]) ? $data["fecha"] : date('Y-m-d');
						$cliente = isset($data["cliente"]) ? $data["cliente"] : 'Cliente General';
						$vendedor = isset($data["vendedor"]) ? $data["vendedor"] : 'Sistema';
						$status = isset($estatus) ? $estatus : '';

						// Calcular totales con validación
						$ventas_totales = (isset($ventas_totales) ? floatval($ventas_totales) : 0) + $totalfact + $abono;

						// Formatear salida para mostrar
						$totalfactura = $moned.' '.number_format($totalfact, 2);
						if ($totalfact == 0 && $abono > 0) {
						    $totalfactura = $moned.' '.number_format($abono, 2);
						}

						?>
						    <tr id="">
							<td><?php echo $nofactura; ?></td>
							<td><?php echo $fecha; ?></td>
							<td><?php echo $cliente; ?></td>
							<td><?php echo $vendedor; ?></td>
							<td class="estado"><?php echo $status; ?></td>
							<td class="totalfactura"><?php echo $totalfactura; ?></td>
							</tr>;

							<?php
							}
					}
				?>
						
			</tbody>	
			<tfoot id="detalle_totales">
				<tr>
					<td colspan="4" class="textright"><h2>Ventas totales</h2><span></span></td>
					<td></td>
					<td class=""><span><?php echo $moned.' '.number_format($ventas_totales,2);?></span></td>
				</tr>
				
		</tfoot>
	</table>
	<div>
		<!--<p class="nota">Si usted tiene preguntas sobre esta venta, <br>pongase en contacto con nombre, teléfono y Email</p>-->
		<!--<h4 class="label_gracias">¡Gracias por su compra!</h4>-->
	</div>

</div>

</body>
</html>