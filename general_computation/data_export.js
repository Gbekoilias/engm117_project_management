// data_export.js

function exportToCSV(data, filename) {
      const csvContent = "data:text/csv;charset=utf-8," 
          + data.map(e => e.join(",")).join("\n");
  
      const encodedUri = encodeURI(csvContent);
      const link = document.createElement("a");
      link.setAttribute("href", encodedUri);
      link.setAttribute("download", filename);
      
      document.body.appendChild(link); // Required for FF
      link.click();
  }
  
  function exportToPDF(content, filename) {
      const doc = new jsPDF();
      
      doc.text(content, 10, 10);
      
      doc.save(filename);
  }
  
  // Example usage:
  const resultsData = [
      ["Category", "Value"],
      ["A", "10"],
      ["B", "20"],
  ];
  
  document.getElementById("export-csv").addEventListener("click", () => {
      exportToCSV(resultsData, 'results.csv');
  });
  
  document.getElementById("export-pdf").addEventListener("click", () => {
      exportToPDF("Analysis Results\n\nCategory A: Value\nCategory B: Value", 'results.pdf');
  });
  