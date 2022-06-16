function showDropdownMenu() {
  const dropdownMenu = document.querySelector('.dropdown-content-menu')
  if (dropdownMenu.classList.contains("menu-displayed")) {
    dropdownMenu.classList.remove("menu-displayed");
  } else {
    dropdownMenu.classList.add("menu-displayed");
  }
} 

document.addEventListener('turbolinks:load', function() {
  const button = document.querySelector('.dropdown-button-menu');
  button.addEventListener('click', showDropdownMenu);
});






