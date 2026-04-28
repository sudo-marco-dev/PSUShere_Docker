# PSUSphere – Student Organization Management

## Overview

PSUSphere is a Django-based web application designed to manage **student organizations**, **college departments**, **academic programs**, and **student memberships** at Pangasinan State University. It provides:

- A public dashboard with real-time statistics (total students, organizations, programs, etc.)
- List, search, and sort pages for each model
- A full Django Admin interface for CRUD operations
- A simple data-seeding command powered by **Faker**
- Secure authentication via **django-allauth** including Google Social Login
- A modern, responsive login/register UI built with **MDB UI Kit** and **Font Awesome**

---

## Key Features

- **College Management** – Track college departments with automated timestamps for record creation and updates.
- **Program Tracking** – Manage academic programs linked directly to their respective colleges.
- **Organization Records** – Maintain a database of student organizations with descriptions and college affiliations.
- **Student Membership** – Register students and manage their memberships in organizations, including join dates.
- **Advanced Admin Interface** – Custom search fields and filters in the Django Admin for efficient data management.
- **Automated Data Seeding** – A management command to generate initial fake data for testing using the Faker library.
- **Google Social Authentication** – Integrated OAuth2 login and registration via `django-allauth`.
- **Custom Login & Registration UI** – Responsive, tabbed auth pages built with MDB UI Kit (Bootstrap) and Font Awesome icons.
- **Dynamic Environment Settings** – `SITE_ID` and `ALLOWED_HOSTS` automatically switch between local development and the PythonAnywhere production environment using Python's `socket` module.

---

## Authors

- Marco Dela Serna
- Ace Camias

---

## Prerequisites

- Python 3.10+
- `pip` and `virtualenv`
- SQLite (default) or any Django-supported database

---

## Setup and Installation

### 1. Clone the Repository

```bash
git clone https://github.com/sudo-marco-dev/PSUSphere.git
cd PSUSphere
```

### 2. Create and Activate a Virtual Environment

```bash
python -m venv psusenv

# Linux / macOS
source psusenv/bin/activate

# Windows
psusenv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r projectsite/requirements.txt
```

### 4. Apply Migrations

```bash
cd projectsite
python manage.py migrate
```

### 5. Create a Superuser

```bash
python manage.py createsuperuser
```

### 6. Configure Google OAuth

1. Go to the [Google Cloud Console](https://console.cloud.google.com/) and create an OAuth 2.0 Client ID.
2. Set the **Authorized redirect URI** to `http://127.0.0.1:8000/accounts/google/login/callback/` (and the PythonAnywhere equivalent for production).
3. Log into the Django Admin at `/admin/`.
4. Under **Sites**, verify your site entry and note its **ID** — ensure `SITE_ID` in `settings.py` matches.
5. Under **Social Applications**, add a new application:
   - Provider: **Google**
   - Client ID and Secret Key from the Google Cloud Console
   - Add your site to **Chosen sites**

### 7. (Optional) Seed Fake Data

```bash
python manage.py create_initial_data
```

### 8. Run the Development Server

```bash
python manage.py runserver
```

Visit `http://127.0.0.1:8000/` in your browser.

---

## Deploying to PythonAnywhere

1. **Create a PythonAnywhere account** and a new web app (choose *Manual configuration → Django*).

2. **Upload the repository** via `git clone` or zip upload into your home directory.

3. **Create a virtualenv** on PythonAnywhere:
   ```bash
   mkvirtualenv --python=python3.13 psusenv
   workon psusenv
   pip install -r ~/PSUSphere/projectsite/requirements.txt
   ```

4. **Configure the Web tab**:
   - **Source code**: `/home/yourusername/PSUSphere/projectsite`
   - **Virtualenv**: `/home/yourusername/.virtualenvs/psusenv`
   - **WSGI file**: edit the auto-generated WSGI file to point `path` to `/home/yourusername/PSUSphere/projectsite`

5. **Run migrations and seed data** (via the Bash console):
   ```bash
   cd ~/PSUSphere/projectsite
   workon psusenv
   python manage.py migrate
   python manage.py create_initial_data   # optional but recommended
   ```

6. **Reload** the web app from the *Web* tab.

7. **Set the production `SITE_ID`**: The `settings.py` automatically sets `SITE_ID = 6` when `pythonanywhere` is detected in the hostname. Confirm the Site entry in the Django Admin matches this ID.

---

## Repository Structure

```
PSUSphere/
├─ psusenv/                  # Python virtual environment (not committed)
└─ projectsite/
    ├─ studentorg/           # Django app: models, views, templates
    │   ├─ models.py         # College, Program, Organization, Student, OrgMember
    │   ├─ views.py          # ListViews with search & sorting logic
    │   ├─ templates/        # App-level HTML templates
    │   └─ management/commands/create_initial_data.py  # Faker seed script
    ├─ projectsite/          # Project settings, URLs, wsgi
    ├─ templates/            # Project-wide templates
    │   ├─ base.html
    │   ├─ account/
    │   │   └─ login.html    # Custom allauth login + register UI (MDB)
    │   └─ socialaccount/
    │       └─ login.html    # Google OAuth confirmation page
    ├─ static/               # Static assets (CSS, JS, images)
    └─ README.md             # This guide
```

---

## Key Pages & Functions

| Page | URL | Main Features |
|---|---|---|
| **Dashboard** | `/` | Total students, organizations, programs, recent joins |
| **Login / Register** | `/accounts/login/` | Tabbed MDB UI Kit form + Google OAuth |
| **Organizations** | `/org_list/` | List, search (`?q=`), sort by college name |
| **Organization Members** | `/orgmember_list/` | Search by student name, sort by name or join date |
| **Programs** | `/program_list/` | Search by program/college, sort by name or college |
| **Students** | `/student_list/` | Search by name or student ID |

---

## Admin Setup

1. Create a superuser: `python manage.py createsuperuser`
2. Log into `/admin/` with your credentials.
3. Models are pre-registered in `studentorg/admin.py`.
4. Use the admin to manage Colleges, Programs, Organizations, Students, OrgMembers, and Social Applications.
5. Always **run migrations** after any model change.

---

## Troubleshooting & Common Deployment Issues

### `ModuleNotFoundError: No module named 'projectsite'`
**Context:** Occurs on PythonAnywhere when the WSGI file cannot find the Django project.
**Fix:** Ensure the `path` variable in the WSGI file **and** the "Source code" directory in the Web tab both point to the folder containing `manage.py` (e.g., `/home/yourusername/PSUSphere/projectsite`), **not** the inner `projectsite/projectsite/` folder.

---

### `OperationalError: no such table: django_site`
**Context:** Appears when first accessing the Django Admin after adding `django.contrib.sites` or `allauth`.
**Fix:** Run `python manage.py migrate` to generate all pending `allauth` and `sites` framework tables.

---

### `ImproperlyConfigured: allauth.account.middleware.AccountMiddleware must be added to settings.MIDDLEWARE`
**Context:** Raised when `django-allauth` is installed but its middleware is missing.
**Fix:** Add the following to the `MIDDLEWARE` list in `settings.py`, directly below `AuthenticationMiddleware`:
```python
'allauth.account.middleware.AccountMiddleware',
```

---

### `DoesNotExist at /accounts/login/` (from `allauth.socialaccount.adapter`)
**Context:** `allauth` cannot find a matching `Site` record for the current domain.
**Fix:** The `SITE_ID` in `settings.py` does not match the database ID for your domain. Identify the correct ID via the Django shell:
```bash
python manage.py shell
```
```python
from django.contrib.sites.models import Site
print([(s.id, s.domain) for s in Site.objects.all()])
```
Update `SITE_ID` in `settings.py` to match the ID for your domain. Also confirm the site is listed under **Chosen sites** on the Social Application's admin page.

---

### `Did Not Connect: Potential Security Issue` (Google OAuth redirect)
**Context:** Browser blocks the redirect back from Google after login, typically in the Philippines.
**Fix:** The CICC (Cybercrime Investigation and Coordinating Center) sometimes aggressively blocks free hosting domains like `pythonanywhere.com` at the ISP level. To bypass this, enable **Secure DNS** in your browser settings:
- **Chrome / Edge**: Settings → Privacy and Security → Security → Use Secure DNS → Choose *Cloudflare (1.1.1.1)* or *Google (8.8.8.8)*
- **Firefox**: Settings → Privacy & Security → Enable DNS over HTTPS

---

## Frequently Asked Questions

**Why does `create_initial_data` sometimes fail?**
The script creates Colleges and Programs first to satisfy foreign-key constraints before creating dependent records.

**How do I add more search fields?**
Extend the `get_queryset` method in the relevant `ListView` in `views.py` and update the search form in the template.

**Can I use PostgreSQL?**
Yes — update `DATABASES` in `settings.py` with your PostgreSQL credentials and run `python manage.py migrate`.

---


