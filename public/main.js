const searchForm = document.getElementById('search-form');
const searchTokenInput = document.getElementById('search-token');
const showAllButton = document.getElementById('show-all');

function fetchExams(url) {
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      const tableBody = document.querySelector('#exam-table tbody');
      tableBody.innerHTML = '';

      data.forEach((exam) => {
        const row = document.createElement('tr');

        const idCell = document.createElement('td');
        idCell.textContent = exam.id;
        row.appendChild(idCell);

        const cpfCell = document.createElement('td');
        cpfCell.textContent = exam.cpf;
        row.appendChild(cpfCell);

        const typeCell = document.createElement('td');
        typeCell.textContent = exam.exam_type;
        row.appendChild(typeCell);

        const limitsCell = document.createElement('td');
        limitsCell.textContent = exam.exam_limits;
        row.appendChild(limitsCell);

        const resultCell = document.createElement('td');
        resultCell.textContent = exam.exam_result;
        row.appendChild(resultCell);

        const tokenCell = document.createElement('td');
        tokenCell.textContent = exam.exam_token;
        row.appendChild(tokenCell);

        tableBody.appendChild(row);
      });
    })
    .catch((error) => console.log(error));
}

searchForm.addEventListener('submit', function(event) {
  event.preventDefault();

  const token = searchTokenInput.value;
  const url = `http://localhost:3000/tests/${token}`;

  fetchExams(url);
});

showAllButton.addEventListener('click', function() {
  const url = 'http://localhost:3000/tests';

  fetchExams(url);
});
