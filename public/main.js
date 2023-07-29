const searchForm = document.getElementById('search-form');
const searchTokenInput = document.getElementById('search-token');
const showAllButton = document.getElementById('show-all');
const itemsPerPage = 3*13; // Paginação
let examsData = [];
let currentPage = 1;

function formatDate(dateString) {
  const [year, month, day] = dateString.split('-');
  return `${day}/${month}/${year}`;
}

function updatePagination() {
  const paginationDiv = document.getElementById('pagination');
  paginationDiv.innerHTML = '';

  const totalPages = Math.ceil(examsData.length / itemsPerPage);
  
  let button = document.createElement('button');
  button.textContent = 'Anterior';
  button.onclick = previousPage;
  button.disabled = currentPage === 1;
  paginationDiv.appendChild(button);

  for (let i = 1; i <= totalPages; i++) {
    let button = document.createElement('button');
    button.textContent = i;
    button.onclick = () => goToPage(i);
    if (i === currentPage) button.disabled = true;
    paginationDiv.appendChild(button);
  }

  button = document.createElement('button');
  button.textContent = 'Próximo';
  button.onclick = nextPage;
  button.disabled = currentPage === totalPages;
  paginationDiv.appendChild(button);
}

function nextPage() {
  if (currentPage * itemsPerPage < examsData.length) goToPage(currentPage + 1);
}

function previousPage() {
  if (currentPage > 1) goToPage(currentPage - 1);
}

function goToPage(pageNumber) {
  currentPage = pageNumber;
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  renderTable(examsData.slice(startIndex, endIndex), false);
  updatePagination();
}

function renderTable(data, tokenView) {
  const tableBody = document.querySelector('#exam-table tbody');
  tableBody.innerHTML = '';
  const cpfHeader = document.getElementById('cpf-header');
  const tokenHeader = document.getElementById('token-header');

  if (tokenView) {
    cpfHeader.style.display = 'none';
    tokenHeader.style.display = 'none';
  } else {
    cpfHeader.style.display = '';
    tokenHeader.style.display = '';
  }

  if (tokenView) {
    cpfHeader.style.display = 'none';
    tokenHeader.style.display = 'none';

    const summaryCard = document.getElementById('summary-card');
    document.getElementById('summary-token').textContent = `Exame token: ${data[0].exam_token}`;
    document.getElementById('summary-patient-name').textContent = data[0].patient_name;
    document.getElementById('summary-info').innerHTML = `
      <strong>Data de nascimento:</strong> ${new Date(data[0].patient_birthdate).toLocaleDateString('pt-BR')}<br>
      <strong>CPF:</strong> ${data[0].cpf}<br>
      <strong>Endereço:</strong> ${data[0].patient_address}, ${data[0].patient_city}/${data[0].patient_state}<br>
      <strong>Médico(a) responsável:</strong> ${data[0].doctor_name} - ${data[0].doctor_email}<br>
      <strong>CRM:</strong> ${data[0].doctor_crm} / ${data[0].doctor_crm_state}<br>
      <strong>Data do exame:</strong> ${new Date(data[0].exam_date).toLocaleDateString('pt-BR')}<br>
    `;
    summaryCard.style.display = '';

  } else {
    cpfHeader.style.display = '';
    tokenHeader.style.display = '';
  }

  data.forEach((exam) => {
    const row = document.createElement('tr');

    const idCell = document.createElement('td');
    idCell.textContent = exam.id;
    row.appendChild(idCell);

    if (!tokenView) {
      const cpfCell = document.createElement('td');
      cpfCell.textContent = exam.cpf;
      row.appendChild(cpfCell);
    }

    const typeCell = document.createElement('td');
    typeCell.textContent = exam.exam_type;
    row.appendChild(typeCell);

    const limitsCell = document.createElement('td');
    limitsCell.textContent = exam.exam_limits;
    row.appendChild(limitsCell);

    const resultCell = document.createElement('td');
    resultCell.textContent = exam.exam_result;
    row.appendChild(resultCell);

    if (!tokenView) {
      const tokenCell = document.createElement('td');
      tokenCell.textContent = exam.exam_token;
      row.appendChild(tokenCell);
    }

    tableBody.appendChild(row);
  });
}

function fetchExams(url, tokenView) {
  document.getElementById('summary-card').style.display = 'none';

  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      if (!tokenView) {
        examsData = data;
        currentPage = 1;
        renderTable(examsData.slice(0, itemsPerPage), tokenView); // = goToPage(1)
        updatePagination();
      } else {
        renderTable(data, tokenView)
        document.getElementById('pagination').innerHTML = '';
      }
    })
    .catch((error) => console.log(error));
}

searchForm.addEventListener('submit', function(event) {
  event.preventDefault();

  const token = searchTokenInput.value;
  const url = `http://localhost:3000/tests/${token}`;

  fetchExams(url, true);
});

showAllButton.addEventListener('click', function() {
  const url = 'http://localhost:3000/tests';

  fetchExams(url, false);
});

const uploadForm = document.getElementById('upload-form');

uploadForm.addEventListener('submit', function(event) {
  event.preventDefault();

  const formData = new FormData(uploadForm);

  fetch('/import', {
    method: 'POST',
    body: formData
  })
  .then(response => {
    // handle response
    if (response.ok) {
      console.log('Upload successful');
    } else {
      console.log('Upload failed');
    }
  })
  .catch(error => console.error('Error:', error));
});
