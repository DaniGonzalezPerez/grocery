let allProducts = [];
let allOrders = [];
let stockMap = {};
let currentFilter = 'todos';
let deleteTargetId = null;

async function init() {
    try {
        allProducts = await fetchAPI('/getProducts');
        document.getElementById('totalProducts').textContent = allProducts.length;
    } catch (e) {
        document.getElementById('productsContainer').innerHTML =
            '<div class="empty-state"><div class="empty-icon">⚠️</div>' +
            '<p>No se pudo conectar con el servidor.<br>Asegúrate de que el backend está ejecutándose en el puerto 5000.</p></div>';
        return;
    }

    try {
        allOrders = await fetchAPI('/getOrders');
        document.getElementById('totalOrders').textContent = allOrders.length;

        const totalRevenue = allOrders.reduce((sum, o) => sum + o.total, 0);
        document.getElementById('totalRevenue').textContent = formatPrice(totalRevenue);

        if (allOrders.length > 0) {
            const lastDate = allOrders.reduce((latest, o) =>
                o.fecha > latest ? o.fecha : latest, allOrders[0].fecha);
            document.getElementById('lastOrderDate').textContent = formatDate(lastDate);
        }
    } catch (e) {
        console.error('Error cargando pedidos:', e);
    }

    // Cargar stock
    try {
        const stockData = await fetchAPI('/getStock');
        stockMap = {};
        stockData.forEach(s => { stockMap[s.id_producto] = s.stock_actual; });
        renderProducts(allProducts);
        checkLowStock(stockData);
    } catch (e) {
        renderProducts(allProducts);
        console.error('Error cargando stock:', e);
    }
}

function checkLowStock(stockData) {
    const lowStock = stockData.filter(s => s.stock_actual < 20);
    const container = document.getElementById('stockAlerts');

    if (lowStock.length === 0) {
        container.style.display = 'none';
        return;
    }

    container.style.display = 'block';
    container.innerHTML =
        '<div class="stock-alert-box">' +
        '<div class="stock-alert-header">' +
        '<span>⚠️ Alerta de stock bajo — Se necesita pedido de reposición</span>' +
        '</div>' +
        '<div class="stock-alert-list">' +
        lowStock.map(s =>
            `<div class="stock-alert-item">` +
            `<span class="stock-alert-name">${s.nombre}</span>` +
            `<span class="stock-badge stock-critical">${s.stock_actual} ${s.unidad_medida}</span>` +
            `</div>`
        ).join('') +
        '</div></div>';
}

function getStockLabel(id_producto, unidad) {
    const stock = stockMap[id_producto];
    if (stock === undefined) return '';
    let cls = 'stock-ok';
    if (stock < 20) cls = 'stock-critical';
    else if (stock < 50) cls = 'stock-warning';
    return `<span class="stock-badge ${cls}">${stock} ${unidad}</span>`;
}

function renderProducts(products) {
    const container = document.getElementById('productsContainer');

    if (products.length === 0) {
        container.innerHTML =
            '<div class="empty-state"><div class="empty-icon">📦</div>' +
            '<p>No se encontraron productos</p></div>';
        return;
    }

    container.innerHTML = products.map(p => {
        const cat = getCategory(p.nombre);
        const nombreEscapado = p.nombre.replace(/'/g, "\\'");
        return `
            <div class="product-card">
                <span class="card-badge ${cat.class}">${cat.name}</span>
                <button class="btn-danger card-delete" onclick="openDeleteModal(${p.id_producto}, '${nombreEscapado}')">X</button>
                <div class="card-icon">${cat.icon}</div>
                <h3>${p.nombre}</h3>
                <p class="unit">${p.unidad_medida}</p>
                <div class="price-row">
                    <span class="price">${formatPrice(p.precio_unidad)} <span>/ ${p.unidad_medida}</span></span>
                    ${getStockLabel(p.id_producto, p.unidad_medida)}
                </div>
            </div>
        `;
    }).join('');
}

function filterProducts() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    let filtered = allProducts;

    if (currentFilter !== 'todos') {
        filtered = filtered.filter(p => getCategoryFilter(p.nombre) === currentFilter);
    }

    if (search) {
        filtered = filtered.filter(p => p.nombre.toLowerCase().includes(search));
    }

    renderProducts(filtered);
}

// ── Añadir producto ──
function openAddModal() {
    document.getElementById('addModal').classList.add('active');
}

function closeAddModal() {
    document.getElementById('addModal').classList.remove('active');
    document.getElementById('productName').value = '';
    document.getElementById('productPrice').value = '';
}

async function addProduct() {
    const nombre = document.getElementById('productName').value.trim();
    const unidad = document.getElementById('productUnit').value;
    const precio = parseFloat(document.getElementById('productPrice').value);

    if (!nombre || isNaN(precio) || precio <= 0) {
        showToast('Completa todos los campos correctamente', true);
        return;
    }

    try {
        await postAPI('/insertProduct', {
            nombre: nombre,
            unidad_medida: unidad,
            precio_unidad: precio
        });
        showToast('Producto añadido correctamente');
        closeAddModal();
        init();
    } catch (e) {
        showToast('Error al añadir el producto', true);
    }
}

// ── Eliminar producto ──
function openDeleteModal(id, nombre) {
    deleteTargetId = id;
    document.getElementById('deleteProductName').textContent = nombre;
    document.getElementById('deleteModal').classList.add('active');
}

function closeDeleteModal() {
    document.getElementById('deleteModal').classList.remove('active');
    deleteTargetId = null;
}

async function confirmDelete() {
    if (!deleteTargetId) return;
    try {
        await deleteAPI('/deleteProduct/' + deleteTargetId);
        showToast('Producto eliminado');
        closeDeleteModal();
        init();
    } catch (e) {
        showToast('Error al eliminar el producto', true);
    }
}

// ── Listeners ──
document.getElementById('searchInput').addEventListener('input', filterProducts);

document.querySelectorAll('.filter-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        currentFilter = btn.dataset.category;
        filterProducts();
    });
});

// Refrescar cada 30 segundos
setInterval(init, 30000);

init();
