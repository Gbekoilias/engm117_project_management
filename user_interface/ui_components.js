// ui_components.js

function createButton(label, onClick) {
      const button = document.createElement('button');
      button.innerText = label;
      
      button.onclick = onClick;
  
      return button;
  }
  
  function createForm(inputs, onSubmit) {
      const form = document.createElement('form');
  
      inputs.forEach(input => {
          const label = document.createElement('label');
          label.innerText = input.label;
  
          const inputField = document.createElement(input.type === 'select' ? 'select' : 'input');
          
          if (input.type === 'select') {
              input.options.forEach(option => {
                  const opt = document.createElement('option');
                  opt.value = option.value;
                  opt.innerText = option.label;
                  inputField.appendChild(opt);
              });
          } else {
              inputField.type = input.type; 
              inputField.placeholder = input.placeholder || '';
          }
  
          form.appendChild(label);
          form.appendChild(inputField);
          
          if (input.required) inputField.required = true; 
      });
  
      const submitButton = createButton('Submit', onSubmit);
      
      form.appendChild(submitButton);
  
      return form;
  }
  