# 1100CC + nodegoat Docker Setup

This Docker Compose setup provides a complete environment for running 1100CC web framework and nodegoat data management system.

## Setup

Clone repositories:

```bash
git clone https://github.com/LAB1100/1100CC.git
git clone https://github.com/nodegoat/nodegoat.git
```

Prepare files:

```bash
cp -r nodegoat/APP/nodegoat 1100CC/APP/
cp -r nodegoat/APP/SETTINGS/nodegoat 1100CC/APP/SETTINGS/
mkdir -p 1100CC/APP/STORAGE/nodegoat/CMS/css
cp nodegoat/APP/STORAGE/nodegoat/CMS/css/templates.css 1100CC/APP/STORAGE/nodegoat/CMS/css/
touch 1100CC/APP/alias
mkdir -p 1100CC/APP/CACHE
mkdir -p 1100CC/SAFE/nodegoat
```

Next we can build and start the containers:

```bash
docker-compose build
docker-compose up -d
```

The database needs time to initialize. Check the database health:

```bash
docker-compose exec db mysql -u root -p1100CC -e "SHOW DATABASES;"
```

Then you can import sql schemas:

```bash
docker-compose exec -T db mysql -u1100CC_cms -pcms_password 1100CC < 1100CC/setup/1100CC.sql
docker-compose exec -T db mysql -u1100CC_cms -pcms_password nodegoat_cms < nodegoat/setup/nodegoat_cms.cms_labels.sql
```

Open your browser on http://localhost (or on your public ip/domain) and follow the 1100CC setup wizard.

After 1100CC is configured:
1. Login to the CMS
2. Go to Admin
3. Run 'Setup 1100CC' to prepare nodegoat's default routines
4. Go to Jobs and ensure the Jobs process is running
5. Create a new user with appropriate permissions

## Additional Resources

- [1100CC Documentation](https://github.com/LAB1100/1100CC)
- [nodegoat Documentation](https://nodegoat.net)
- [1100CC Setup Guide](https://github.com/LAB1100/1100CC/blob/master/SETUP.md)
- [nodegoat Setup Guide](https://github.com/nodegoat/nodegoat/blob/master/SETUP.md)

For issues:
- 1100CC: https://github.com/LAB1100/1100CC/issues
- nodegoat: https://github.com/nodegoat/nodegoat/issues

## License

- 1100CC: GNU AGPLv3
- nodegoat: GNU AGPLv3
