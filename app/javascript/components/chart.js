import Chart from 'chart.js';

const initChart = () => {
  const ctx = document.getElementById("myChart");
  const presence = ctx.dataset.presence;

  const myDoughnutChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
      datasets: [{
          data: [presence, 52],
          backgroundColor: ["#f38181", "#E5E5E5"],
      }],

      // These labels appear in the legend and in the tooltips when hovering different arcs
      labels: [
          'Présent',
          'Absent',
      ]
  },
      options: { cutoutPercentage: 50
      }
  });
}

export { initChart };


