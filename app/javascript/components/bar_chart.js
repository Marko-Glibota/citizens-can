import Chart from 'chart.js';

const initBarChart = () => {
  const ctx = document.getElementById("myBarChart");
  const propositionsDeposees = ctx.dataset.deposees;
  const propositionsSignees = ctx.dataset.signees;
  const BarChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
      labels: ["Propositions déposées", "Propositions signées"],
      datasets: [
        {
          barThickness: 24,
          maxBarThickness: 32,
          backgroundColor: ["#f38181", "#EED489"],
          data: [propositionsDeposees,propositionsSignees]
        }
      ]
    },
    options: {
      legend: { display: false },
      title: {
        display: false,
        text: 'Propositions de lois'
      }
    }
  });
}

export { initBarChart };
