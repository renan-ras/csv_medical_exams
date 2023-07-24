const url = 'http://localhost:3000/tests';

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
