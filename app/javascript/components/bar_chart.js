import Chart from 'chart.js';

const initBarChart = () => {
  const ctx = document.getElementById("myBarChart");
  const propositionDeposee = ctx.dataset.proposition.deposee;
  const propositionSignee = ctx.dataset.proposition.signee;

  const myBarChart = new Chart(ctx, {
      type: 'horizontalBar',
      data: {
      datasets: [{
          data: [],
          backgroundColor: ["#f38181", "#E5E5E5"],
      }],

      // These labels appear in the legend and in the tooltips when hovering different arcs
      labels: [
          'Propositions déposées',
          'Propositions signées',
      ]
  }
  });
}

export { initBarChart };
