let allOrders = [];

async function init() {
    try {
        allOrders = await fetchAPI('/getOrders');
        updateStats(allOrders);
        renderTable(allOrders);
    } catch (e) {
        document.getElementById('ordersTableBody').innerHTML =
            '<tr><td colspan="6"><div class="empty-state"><div class="empty-icon">⚠️</div>' +
            '<p>No se pudo conectar con el servidor</p></div></td></tr>';
    }
}

function updateStats(orders) {
    document.getElementById('totalOrders').textContent = orders.length;

    const total = orders.reduce((sum, o) => sum + o.total, 0);
    document.getElementById('totalRevenue').textContent = formatPrice(total);

    if (orders.length > 0) {
        const lastDate = orders.reduce((latest, o) =>
            o.fecha > latest ? o.fecha : latest, orders[0].fecha);
        document.getElementById('lastOrderDate').textContent = formatDate(lastDate);
    }
}

function renderTable(orders) {
    const tbody = document.getElementById('ordersTableBody');

    if (orders.length === 0) {
        tbody.innerHTML =
            '<tr><td colspan="6"><div class="empty-state"><div class="empty-icon">🛒</div>' +
            '<p>No se encontraron pedidos</p></div></td></tr>';
        return;
    }

    tbody.innerHTML = orders.map(o => `
        <tr>
            <td><strong>#${o.id_pedido}</strong></td>
            <td class="client-name">${o.nombre_cliente}</td>
            <td><span class="badge-productos">${o.num_productos} productos</span></td>
            <td class="order-total">${formatPrice(o.total)}</td>
            <td class="order-date">${formatDate(o.fecha)}</td>
            <td>
                <button class="btn-primary" style="padding: 6px 14px; font-size: 0.8rem;" onclick="viewDetails(${o.id_pedido}, '${o.nombre_cliente.replace(/'/g, "\\'")}', ${o.total})">
                    Ver detalle
                </button>
            </td>
        </tr>
    `).join('');
}

document.getElementById('searchInput').addEventListener('input', (e) => {
    const search = e.target.value.toLowerCase();
    const filtered = allOrders.filter(o => o.nombre_cliente.toLowerCase().includes(search));
    renderTable(filtered);
});

async function viewDetails(idPedido, clienteName, total) {
    document.getElementById('detailModalTitle').textContent = 'Pedido #' + idPedido;
    document.getElementById('detailClientName').textContent = 'Cliente: ' + clienteName;
    document.getElementById('detailTotal').textContent = formatPrice(total);
    document.getElementById('detailModal').classList.add('active');

    const tbody = document.getElementById('detailTableBody');
    tbody.innerHTML = '<tr><td colspan="5"><div class="loading"><div class="spinner"></div></div></td></tr>';

    try {
        const detalles = await fetchAPI('/getOrderDetails/' + idPedido);
        tbody.innerHTML = detalles.map(d => `
            <tr>
                <td>${d.nombre}</td>
                <td>${d.unidad_medida}</td>
                <td>${d.cantidad}</td>
                <td>${formatPrice(d.precio_unidad)}</td>
                <td><strong>${formatPrice(d.precio_total)}</strong></td>
            </tr>
        `).join('');
    } catch (e) {
        tbody.innerHTML = '<tr><td colspan="5">Error al cargar detalles</td></tr>';
    }
}

function closeDetailModal() {
    document.getElementById('detailModal').classList.remove('active');
}

init();
