
# Creating a new AWS account

![Descripción de la imagen](https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png)

## Para crear un nuevocuenta de AWS, necesitará lo siguiente

- Una dirección de correo electrónico (o alias) que no se haya utilizado antes para registrar una cuenta de AWS
- Un número de teléfono que se puede usar para fines importantes de verificación de la cuenta.
- Su tarjeta de crédito o débito para validar, `solo se le cobrará  por el uso de AWS fuera de la capa gratuita`  

## Pasos para la creación de una nueva cuenta de AWS

1. Vaya a la página de AWS en <http://aws.amazon.com>

2. Haga clic en el enlace Crear una cuenta de AWS.

3. Proporcione una dirección de correo electrónico, especifique una contraseña segura y proporcione un nombre para su cuenta.

    SUGERENCIA SOBRE CÓMO REUTILIZAR UNA DIRECCIÓN DE CORREO ELECTRÓNICO EXISTENTE
    Algunos sistemas de correo electrónico admiten agregar un signo + seguido de algunos caracteres al final de la parte del nombre de usuario de su dirección de correo electrónico para crear una dirección de correo electrónico única que aún va a su mismo buzón. Por ejemplo, `daniel.emailaddress@gmail.com` y `daniel.emailaddress+dataengineering@gmail.com`. Puede usar este consejo para proporcionar una dirección de correo electrónico única durante el registro, pero aún recibir correos electrónicos en su cuenta principal.

4. Seleccione Profesional o Personal para el tipo de cuenta (tenga en cuenta que la funcionalidad y las herramientas disponibles son las mismas sin importar cuál elija).
    ![Descripción de la imagen](/AWS/img/B16852_01_01.jpeg)

5. Proporcione lo solicitadoinformación personal y luego, después haga click en la casilla de verificación si está de acuerdo con los términos y luego haga click en Crear cuenta y continuar.

6. Proporcione una tarjeta de crédito o débito para la información de pago y seleccione Verificar y agregar.

7. Proporcione un número de teléfono para un texto de verificación o una llamada.
    ![Descripción de la imagen](/AWS/img/B16852_01_02.jpeg)

8. Seleccione un plan de soporte.
Recibirás unnotificación de que su cuenta está siendo activada. Esto generalmente se completa en unos minutos, pero puede demorar hasta 24 horas. Revisa tu correo electrónico para confirmar la activación de la cuenta.

## Acceso a su cuenta de AWS

Una vez que haya recibidoel correo electrónico de confirmación que confirma que su cuenta ha sido activada, siga estos pasos para acceder a su cuenta y crear un nuevo usuario administrador:

1. Acceda a la página de inicio de sesión de la consola de AWS en <http://console.aws.amazon.com>.

2. Asegúrese de que el usuario raíz esté seleccionado y luego ingrese la dirección de correo electrónico que utilizó al crear la cuenta.
3. Introduzca la contraseña que estableció al crear la cuenta.
     Es una buena práctica recomendada que no use este inicio de sesión para sus actividades diarias, sino que solo lo use cuando realice actividades.que requieren la cuenta raíz, como crear su primer usuario de Gestión de acceso e identidad ( IAM ), eliminar la cuenta o cambiar la configuración de su cuenta. Para obtener más información, consulte <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html>.
    También se recomienda que habilite la autenticación multifactor ( MFA ) en este y otroscuentas administrativas. Para habilitar esto, consulte <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa_enable_virtual.html>.

## crear una nueva cuenta de usuario administrativo de IAM

1. En la consola de administración de AWS, confirme en qué región se encuentra actualmente.
    En la siguiente captura de pantalla, el usuario se encuentra en la región de Ohio (también conocida como us-east-2):
    ![Descripción de la imagen](/AWS/img/B16852_01_03.jpeg)

2. En el buscador de la parte superior central de la pantalla, escriba IAM y presione Entrar.
3. En el menú del lado izquierdo, haga clic en Usuarios y luego en Agregar usuario.
4. Proporcione un nombre de usuario y seleccione tanto el acceso programático como el acceso a la consola de administración de AWS.
5. Establezca una contraseña para la consola y seleccione si desea forzar un cambio de contraseña en el próximo inicio de sesión, luego haga click en Next.
    ![Descripción de la imagen](/AWS/img/B16852_01_04.jpeg)

6. Para simplificar la configuración de nuestra cuenta de prueba, usaremos la política administrada de `AdministratorAccess`. Esta política brinda acceso completo a todos los recursos de AWS en la cuenta.

    En la pantalla Establecer permisos , seleccione Adjuntar políticas existentes directamente. En la lista de políticas, seleccione AdministratorAccess. Luego, haz click en Siguiente.
    ![Descripción de la imagen](/AWS/img/iam005.png)

7. Opcionalmente, especifique etiquetas (clave-valor), luego haga clic en Siguiente.
8. Revise la configuración y luego haga click en Crear usuario .
9. Tome nota de la URL para iniciar sesión en su cuenta.
10. Tome nota del ID de la clave de acceso y la clave de acceso secreta, ya que las necesitará más adelante. (Esta es la única oportunidad que tendrá para registrar la clave de acceso secreta, por lo que es importantepara registrar de forma segura esta información ahora)
    ![Descripción de la imagen](/AWS/img/B16852_01_05.jpeg)

** De ahora en adelante debe iniciar sesión con la URL proporcionada y el nombre de usuario y la contraseña que configuró para su usuario de IAM. También debe considerar habilitar MFA para esta cuenta, una mejor práctica recomendada para todas las cuentas con permisos de administrador.

## Instalación y configuración de la CLI de AWS

Para configurar la CLI de AWS, necesita una ID y clave de acceso secreta para un usuario administrativo de IAM.

1. Descarga el apropiado Instalador de AWS CLI v2 para su plataforma (Mac, Windows o Linux) desde <https://aws.amazon.com/es/cli/>
2. Ejecute el instalador para completar la instalación de la AWS CLI.
3. Para configurar la CLI, ejecute `aws configure [--profile profile_alias]` en el símbolo del sistema y proporcione el AWS Access Key ID y AWS Secret Access Key para su usuario de IAM. Además, proporcione una región predeterminada: en los ejemplos usaremos us-east-1 (Virginia).

    ```shell
    $aws configure
    AWS Access Key ID [None]: AKIAX9LFIEPF3KKQUI
    AWS Secret Access Key [None]: neKLcXPXlabP9C90a0qeBkWZAbnbM4ihesP9N1u3
    Default region name [None]: us-east-1
    Default output format [None]: json
    ```

4. listar todos los perfiles configurados

    `aws configure list [--profile profile-name]`

    `aws configure list-profiles`
