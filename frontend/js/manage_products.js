let allProducts = [];
let deleteTargetId = null;

async function init() {
    try {
        allProducts = await fetchAPI('/getProducts');
        renderTable(allProducts);
    } catch (e) {
        document.getElementById('productsTableBody').innerHTML =
            '<tr><td colspan="6"><div class="empty-state"><div class="empty-icon">⚠️</div>' +
            '<p>No se pudo conectar con el servidor</p></div></td></tr>';
    }
}

function renderTable(products) {
    const tbody = document.getElementById('productsTableBody');

    if (products.length === 0) {
        tbody.innerHTML =
            '<tr><td colspan="6"><div class="empty-state"><div class="empty-icon">📦</div>' +
            '<p>No se encontraron productos</p></div></td></tr>';
        return;
    }

    tbody.innerHTML = products.map(p => {
        const cat = getCategory(p.nombre);
        return `
            <tr>
                <td><strong>#${p.id_producto}</strong></td>
                <td>${p.nombre}</td>
                <td>${p.unidad_medida}</td>
                <td><strong>${formatPrice(p.precio_unidad)}</strong></td>
                <td><span class="card-badge ${cat.class}" style="position:static;">${cat.name}</span></td>
                <td>
                    <button class="btn-danger" onclick="openDeleteModal(${p.id_producto}, '${p.nombre.replace(/'/g, "\\'")}')">
                        Eliminar
                    </button>
                </td>
            </tr>
        `;
    }).join('');
}

document.getElementById('searchInput').addEventListener('input', (e) => {
    const search = e.target.value.toLowerCase();
    const filtered = allProducts.filter(p => p.nombre.toLowerCase().includes(search));
    renderTable(filtered);
});

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

init();
