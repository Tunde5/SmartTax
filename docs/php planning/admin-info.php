<?php
require_once 'config/db.php';

$dbInfo = getDatabaseInfo();
$tables = getTables();
?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>SmartTax - Admin Info</title>
	<style>
		body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
		.container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
		h1 { color: #333; }
		.info-section { margin: 20px 0; padding: 15px; background: #f9f9f9; border-left: 4px solid #007bff; }
		.status-success { color: #28a745; font-weight: bold; }
		.status-error { color: #dc3545; font-weight: bold; }
		table { width: 100%; border-collapse: collapse; margin-top: 10px; }
		th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
		th { background: #f0f0f0; font-weight: bold; }
		a { color: #007bff; text-decoration: none; }
		a:hover { text-decoration: underline; }
	</style>
</head>
<body>
	<div class="container">
		<h1>SmartTax - Admin Info</h1>
		
		<div class="info-section">
			<h2>Server Information</h2>
			<p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
			<p><strong>Server:</strong> <?php echo $_SERVER['SERVER_NAME'] ?? 'localhost'; ?></p>
			<p><strong>Request Time:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
		</div>

		<div class="info-section">
			<h2>Database Status</h2>
			<?php if ($dbInfo['status'] === 'connected'): ?>
				<p class="status-success">✓ Database Connected</p>
				<table>
					<tr>
						<th>Property</th>
						<th>Value</th>
					</tr>
					<tr>
						<td>Host</td>
						<td><?php echo htmlspecialchars($dbInfo['host']); ?></td>
					</tr>
					<tr>
						<td>Database</td>
						<td><?php echo htmlspecialchars($dbInfo['database']); ?></td>
					</tr>
					<tr>
						<td>User</td>
						<td><?php echo htmlspecialchars($dbInfo['user']); ?></td>
					</tr>
					<tr>
						<td>Server Version</td>
						<td><?php echo htmlspecialchars($dbInfo['version']); ?></td>
					</tr>
				</table>
			<?php else: ?>
				<p class="status-error">✗ Database Connection Failed</p>
				<p><?php echo htmlspecialchars($dbInfo['message']); ?></p>
			<?php endif; ?>
		</div>

		<?php if ($dbInfo['status'] === 'connected' && !empty($tables)): ?>
		<div class="info-section">
			<h2>Database Tables</h2>
			<p>Total tables: <strong><?php echo count($tables); ?></strong></p>
			<ul>
				<?php foreach ($tables as $table): ?>
					<li><?php echo htmlspecialchars($table); ?></li>
				<?php endforeach; ?>
			</ul>
		</div>
		<?php endif; ?>

		<div class="info-section">
			<h2>Quick Links</h2>
			<ul>
				<li><a href="http://localhost:8081" target="_blank">phpMyAdmin (Port 8081)</a></li>
				<li><a href="/" target="_blank">Back to Home</a></li>
			</ul>
		</div>
	</div>
</body>
</html>
