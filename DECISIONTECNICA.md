
Decisiones Técnicas - BankApp - Jorge David Espina Molina

¿Por qué Flutter Riverpod y no Bloc?
Elegimos Riverpod porque el equipo ya lo manejaba en el proyecto experience_app. Además, con Riverpod podemos tener providers sin necesidad de un BuildContext, lo que simplifica mucho cuando queremos acceder al estado desde cualquier parte. Bloc es bueno pero añade más boilerplate (events, states, bloc class) para cosas que con un Notifier se resuelven en menos líneas.

¿Por qué separamos en features?
La idea es que si mañana entra un compañero nuevo al equipo, pueda trabajar en el módulo de transfers sin necesidad de entender cómo funciona authentication. Cada feature tiene su propia carpeta con data, domain y presentation. Si alguien rompe algo en dashboard, no afecta al login.

¿Por qué Clean Architecture (data/domain/presentation)?
Nos permite cambiar la fuente de datos sin tocar la UI. Hoy los productos del dashboard son datos mock, pero cuando el backend esté listo solo hay que cambiar el datasource remoto. La pantalla ni se entera porque consume una entidad del domain, no un modelo del API.

¿Por qué GoRouter?
Lo elegimos porque necesitábamos controlar la navegación con guards (si el usuario no está logueado, redirigir al login). GoRouter nos da eso de forma declarativa y además soporta deep linking si a futuro lo necesitamos para notificaciones push.

¿Por qué SharedPreferences para el cache?
Para este caso (guardar los últimos saldos conocidos y la preferencia de idioma) no necesitamos una base de datos completa. SharedPreferences es liviano, rápido de implementar y suficiente para persistir JSON pequeños. Si a futuro el cache crece, migraríamos a Hive o SQLite.

¿Por qué archivos ARB para internacionalización?
Es la solución oficial de Flutter. Los archivos .arb son JSON que cualquier persona del equipo puede editar sin saber Dart. Además, si en algún momento necesitamos enviar las traducciones a un traductor profesional, los .arb son un formato estándar que las herramientas de localización entienden.

¿Por qué el state se divide en 3 archivos (providers, state, controller)?
Porque así cada archivo tiene una sola responsabilidad:
providers.dart define la inyección de dependencias (qué depende de qué)
state.dart es solo la estructura de datos (qué información maneja la pantalla)
controller.dart es la lógica (qué hacer cuando el usuario interactúa)
Si necesitas debuggear por qué un dato no llega, vas al provider. Si un campo está mal, vas al state. Si una acción no funciona, vas al controller.

¿Por qué el Model tiene toEntity() y fromEntity()?
Para no acoplar la UI a la estructura del API. Si el backend cambia el nombre de un campo de balance a available_balance, solo tocamos el Model y el mapeo. La entidad, el controller y la pantalla quedan intactos.
 
------------------------------------------------------------------------------------------------------------------------------------------

Decisiones Técnicas - BankApp - Luis Fernando Chuvac Ventura

¿Por qué Flutter Riverpod y no Bloc?
Apoyo la decisión de usar Riverpod porque se adapta mejor a la forma en que estamos estructurando el proyecto. Nos permite manejar el estado de forma más limpia, sin depender directamente del BuildContext, y facilita separar la lógica de la UI. Para un proyecto bancario, donde hay flujos como autenticación, dashboard, transferencias y pagos, Riverpod ayuda a mantener el código más ordenado y fácil de probar.

¿Por qué separamos en features?
Separar por features permite que cada módulo tenga independencia. En nuestro caso, authentication, dashboard, transfers o payments pueden crecer sin mezclarse entre sí. Esto ayuda a que el equipo trabaje en paralelo, reduce conflictos en el código y hace más sencillo encontrar errores o agregar nuevas funcionalidades.

¿Por qué Clean Architecture?
Considero que Clean Architecture es una buena decisión porque nos permite separar responsabilidades. La capa presentation se enfoca en la interfaz, domain en las reglas de negocio y data en la fuente de información. Esto es útil porque hoy podemos usar datos mock, pero mañana conectarnos a un backend real sin reescribir toda la pantalla.

¿Por qué GoRouter?
GoRouter nos ayuda a manejar mejor la navegación, especialmente porque el proyecto necesita rutas protegidas. En una aplicación bancaria no cualquier usuario debe acceder al home o a transferencias sin estar autenticado. Además, permite tener una navegación más clara y preparada para futuros escenarios como deep links o redirecciones automáticas.

¿Por qué SharedPreferences para el cache?
SharedPreferences es suficiente para guardar información pequeña como token, sesión, idioma o preferencias del usuario. No necesitamos una base de datos local pesada para datos simples. Además, al ser fácil de implementar, nos permite avanzar rápido sin complicar la arquitectura.

¿Por qué archivos ARB para internacionalización?
Usar archivos ARB es conveniente porque es la forma recomendada por Flutter para manejar varios idiomas. También permite separar los textos del código, evitando tener cadenas escritas directamente en las pantallas. Esto facilita mantener la aplicación preparada para más idiomas en el futuro.

¿Por qué dividir el state en providers, state y controller?
Esta separación ayuda a que el código sea más entendible. Los providers sirven para inyectar dependencias, el state representa la información actual de la pantalla y el controller contiene la lógica de interacción. Así evitamos tener archivos muy grandes y mezclados, y cualquier cambio es más fácil de ubicar.

¿Por qué el Model tiene toEntity() y fromEntity()?
Esto nos ayuda a mantener separada la estructura del backend de la lógica interna de la aplicación. El Model representa cómo viene la información desde la API o datasource, mientras que la Entity representa lo que realmente usa el dominio. Si el backend cambia un campo, solo ajustamos el modelo y el mapeo, sin afectar las pantallas ni la lógica principal.
