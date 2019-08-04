# About
Bootstrap an **OctoberCMS** local development environment with [LANDO](https://docs.devwithlando.io/) and [OFFLINE-GmbH/oc-bootstrapper](https://github.com/OFFLINE-GmbH/oc-bootstrapper)


## Setup

0. Install the latest release of [lando](https://github.com/lando/lando/releases) depending on your OS system if it's not already done.

1. Create a directory for you octoberCMS instance, let's name it **chkilel**

2. CD to this directory: 
    ```
    $ CD chkilel
    ```
3. Clone the repo
    ```
    $ git clone https://github.com/chkilel/oc-lando-setup.git .
    ```

4. Modify the APP name in the .lando.yml file, the APP name, must be unique, check the exitance of the APP by running `lando list --all` befor starting the APP, See comments in the file.
    ```yaml
    name: nameOfTheApp # MUST BE MODIFIED BEFOR FIRING UP THE LOCAL DEV ENVIRONMENT
    ```

5. Start the APP by running
    ```
    $ lando start
    ```
    After the local dev fire up, you will see
    ```
    BOOMSHAKALAKA!!!

    Your app has started up correctly.
    Here are some vitals:

    NAME            chkilel                           
    LOCATION        /Users/Adil/Sites/october/chkilel 
    SERVICES        appserver, database               
    APPSERVER URLS  https://localhost:32900           
                    http://localhost:32901            
                    http://chkilel.lndo.site          
                    https://chkilel.lndo.site
    ```        


6. Initialize your project, use the october init command to create a new empty project with a config file:
    ```
    $ lando october init
    ```

7. Change your configuration in your newly created project directory you'll find an october.yaml file. Edit its contents to suite your needs, refere to [oc-bootstrapper](https://github.com/OFFLINE-GmbH/oc-bootstrapper) for more details
    ```yaml
    app:
    url: 'http://chkilel.lndo.site'
    locale: en
    debug: true

    cms:
        theme: oc-bootstrap (https://github.com/prismify/oc-bootstrap-theme.git)
        edgeUpdates: false
        enableSafeMode: false
        # project: XXXX            # Marketplace project ID

    database:
        connection: mysql
        host: database # naming convention for LANDO, alaways default host is database
        username: lamp # the name is the same as the recipe name of the .lando.yml file
        password: lamp # the name is the same as the recipe name of the .lando.yml file
        database: lamp # the name is the same as the recipe name of the .lando.yml file

    plugins:
        - Rainlab.Pages
        - Rainlab.Builder
        - Indikator.Backend
        - OFFLINE.SiteSearch
        - OFFLINE.ResponsiveImages
        - OFFLINE.GDPR (https://github.com/OFFLINE-GmbH/oc-gdpr-plugin.git)
        - ^OFFLINE.Mall (https://github.com/OFFLINE-GmbH/oc-mall-plugin.git#develop)
        # - Vendor.Private (user@remote.git)
        # - Vendor.PrivateCustomBranch (user@remote.git#branch)

    mail:
        host: smtp.mailgun.org
        name: User Name
        address: email@example.com
        driver: log
    ```

8. When you are done editing your configuration file, simply run `october install` to install October. **oc-bootstrapper** will take care of setting everything up for you. You can run this command locally after checking out a project repository or during deployment.
This command is idempotent, it will only install what is missing on subsequent calls.
    ```
    $ lando october install
    ```
    Use the --help flag to see all available options.

    ```
    lando october install --help
    ````

9. If at any point in time you need to **install additional plugins**, simply add them to your october.yaml and re-run `october install`. Missing plugins will be installed.

10. If you want to **update the installation** you can run
    ```
    $ lando october update
    ```

11. To push local changes to the current **git remote** run
    ```
    $ lando october push
    ```

***
# If you are actively developing a site and would like to get the latest and greatest changes for October when updating, then

12. Change the following config files

    - **config/app.php**
     ``` php
     'name' => 'October CMS' // Your App/Site name
     ```

    - **config/cms.php**
    ```php
    edgeUpdates = true // Enables updating plugins not managed by composer to their edge (develop) versions
    backendTimezone = 'UTC' // Whatever timezone most of your backend users will find useful as a default
    disableCoreUpdates = true // Disables updating the core through the backend interface, this should be managed by composer only
    ```

12. Run the script below 
    ```shell
    $ setupDev.sh
    ```
    If it need make it executable
    ```shell
    $ chmod +x setupDev.sh
    ```
    