document.addEventListener('DOMContentLoaded', function() {
    // Función para mostrar un mensaje de bienvenida
    function showWelcomeMessage() {
        const welcomeMessage = document.createElement('div');
        welcomeMessage.id = 'welcome-message';
        welcomeMessage.textContent = '¡Bienvenido a nuestra página!';
        welcomeMessage.style.position = 'fixed';
        welcomeMessage.style.top = '20px';
        welcomeMessage.style.left = '50%';
        welcomeMessage.style.transform = 'translateX(-50%)';
        welcomeMessage.style.padding = '10px 20px';
        welcomeMessage.style.backgroundColor = '#4CAF50';
        welcomeMessage.style.color = 'white';
        welcomeMessage.style.borderRadius = '5px';
        welcomeMessage.style.zIndex = '1000';
        welcomeMessage.style.boxShadow = '0 2px 5px rgba(0,0,0,0.2)';
        document.body.appendChild(welcomeMessage);

        // Ocultar el mensaje después de 3 segundos
        setTimeout(function() {
            welcomeMessage.style.opacity = '0';
            setTimeout(function() {
                welcomeMessage.remove();
            }, 500);
        }, 3000);
    }

    // Función para manejar el evento de clic en el botón
    function handleButtonClick() {
        const button = document.getElementById('action-button');
        if (button) {
            button.addEventListener('click', function() {
                alert('¡Botón clickeado!');
            });
        }
    }

    // Función para registrar eventos de scroll
    function trackScrollEvents() {
        let scrollTimeout;
        window.addEventListener('scroll', function() {
            clearTimeout(scrollTimeout);
            scrollTimeout = setTimeout(function() {
                console.log('Usuario ha terminado de hacer scroll. Posición actual:', window.scrollY);
            }, 200);
        });
    }

    // Función para manejar el evento de cambio de tamaño de ventana
    function handleResize() {
        window.addEventListener('resize', function() {
            console.log('Tamaño de ventana cambiado. Nuevo ancho:', window.innerWidth, 'Nuevo alto:', window.innerHeight);
        });
    }

    // Función para registrar eventos de clic en enlaces
    function trackLinkClicks() {
        document.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', function(e) {
                console.log('Enlace clickeado:', this.href);
            });
        });
    }

    // Inicializar todas las funcionalidades
    function init() {
        showWelcomeMessage();
        handleButtonClick();
        trackScrollEvents();
        handleResize();
        trackLinkClicks();
    }

    // Iniciar la aplicación cuando el DOM esté completamente cargado
    init();
});