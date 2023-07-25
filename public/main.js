const searchForm = document.getElementById('search-form');
const searchTokenInput = document.getElementById('search-token');
const showAllButton = document.getElementById('show-all');

function fetchExams(url, tokenView) {
  document.getElementById('summary-card').style.display = 'none';

  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      const tableBody = document.querySelector('#exam-table tbody');
      tableBody.innerHTML = '';

      const cpfHeader = document.getElementById('cpf-header');
      const tokenHeader = document.getElementById('token-header');

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
