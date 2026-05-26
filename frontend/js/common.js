const API_BASE = '';

async function fetchAPI(endpoint) {
    const response = await fetch(API_BASE + endpoint);
    if (!response.ok) throw new Error('Error en la petición');
    return response.json();
}

async function postAPI(endpoint, data) {
    const response = await fetch(API_BASE + endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    if (!response.ok) throw new Error('Error en la petición');
    return response.json();
}

async function deleteAPI(endpoint) {
    const response = await fetch(API_BASE + endpoint, { method: 'DELETE' });
    if (!response.ok) throw new Error('Error en la petición');
    return response.json();
}

function showToast(message, isError = false) {
    const toast = document.getElementById('toast');
    toast.textContent = message;
    toast.className = 'toast show' + (isError ? ' error' : '');
    setTimeout(() => { toast.className = 'toast'; }, 3000);
}

function formatPrice(price) {
    return Number(price).toFixed(2) + ' €';
}

function formatDate(dateStr) {
    if (!dateStr) return '-';
    const parts = dateStr.split('-');
    if (parts.length !== 3) return dateStr;
    const meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun',
                   'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
    return parts[2] + ' ' + meses[parseInt(parts[1], 10) - 1] + ' ' + parts[0];
}

function getCategory(nombre) {
    const n = nombre.toLowerCase();
    if (n.includes('leche') || n.includes('yogur') || n.includes('mantequilla') || n.includes('queso'))
        return { name: 'Lácteo', class: 'badge-lacteo', icon: '🥛' };
    if (n.includes('pan') || n.includes('barra'))
        return { name: 'Panadería', class: 'badge-panaderia', icon: '🍞' };
    if (n.includes('tomate') || n.includes('patata') || n.includes('cebolla') || n.includes('zanahoria'))
        return { name: 'Verdura', class: 'badge-verdura', icon: '🥬' };
    if (n.includes('sardina') || n.includes('lenteja') || n.includes('garbanzo'))
        return { name: 'Conserva', class: 'badge-conserva', icon: '🥫' };
    if (n.includes('huevo'))
        return { name: 'Lácteo', class: 'badge-lacteo', icon: '🥚' };
    if (n.includes('aceite'))
        return { name: 'Despensa', class: 'badge-despensa', icon: '🫒' };
    if (n.includes('arroz') || n.includes('pasta') || n.includes('macarron'))
        return { name: 'Despensa', class: 'badge-despensa', icon: '🍚' };
    return { name: 'Despensa', class: 'badge-despensa', icon: '📦' };
}

function getCategoryFilter(nombre) {
    const cat = getCategory(nombre);
    if (cat.name === 'Lácteo') return 'lacteo';
    if (cat.name === 'Panadería') return 'panaderia';
    if (cat.name === 'Verdura') return 'verdura';
    if (cat.name === 'Conserva') return 'despensa';
    return 'despensa';
}
