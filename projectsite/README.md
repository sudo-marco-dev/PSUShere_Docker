# PSUSphere – Student Organization Management

## Overview
PSUSphere is a Django web application that lets a university manage **organizations**, **programs**, **students**, and **membership**. It provides:
- A public dashboard with statistics (total students, organizations, programs, etc.)
- List, search, and sort pages for each model
- Admin interface for CRUD operations
- A simple data‑seeding command using **Faker**

---

## Prerequisites
- Python 3.13 (or 3.10+)
- `pip` and `virtualenv`
- SQLite (default) or any other DB supported by Django

---

## Local Setup
```bash
# Clone the repo
git clone https://github.com/sudo-marco-dev/PSUSphere.git
cd PSUSphere/projectsite

# Create and activate a virtual environment
python -m venv ../psusenv
source ../psusenv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Apply migrations
python manage.py migrate

# (Optional) Load fake data
python manage.py create_initial_data

# Run the development server
python manage.py runserver
```
Visit `http://127.0.0.1:8000/` in your browser.

---

## Deploying to PythonAnywhere
1. **Create a PythonAnywhere account** and a new web app (choose *Manual configuration* → *Django*).
2. **Upload the repository** (git clone or upload a zip) into your home directory.
3. **Create a virtualenv** on PythonAnywhere:
   ```bash
   mkvirtualenv --python=python3.13 psusenv
   workon psusenv
   pip install -r requirements.txt
   ```
4. **Configure the web app**:
   - Set *Source code* to `/home/yourusername/PSUSphere/projectsite`
   - Set *Virtualenv* to `/home/yourusername/.virtualenvs/psusenv`
   - Set *WSGI file* to point to `projectsite/wsgi.py`
5. **Run migrations & seed data** (via the Bash console):
   ```bash
   cd ~/PSUSphere/projectsite
   workon psusenv
   python manage.py migrate
   python manage.py create_initial_data   # optional but recommended
   ```
6. **Reload** the web app from the *Web* tab.

---

## Repository Structure
```
projectsite/
├─ studentorg/          # Django app containing models, views, templates
│   ├─ models.py       # College, Program, Organization, Student, OrgMember
│   ├─ views.py        # ListViews with search & sorting logic
│   ├─ templates/      # HTML templates (home, orgmember_list, program_list, …)
│   └─ management/commands/create_initial_data.py   # Faker seed script
├─ projectsite/         # Project settings, URLs, wsgi
├─ static/              # Static assets (CSS, JS, images)
└─ README.md            # This guide
```

---

## Key Pages & Functions
| Page | URL | Main Features |
|------|-----|---------------|
| **Dashboard** | `/` | Shows total students, organizations, programs, and recent joins |
| **Organizations** | `/org_list/` | List, search (`?q=`), sort by college name |
| **Organization Members** | `/orgmember_list/` | List, search by student name, sort by first/last name or date joined |
| **Programs** | `/program_list/` | List, search by program/college, sort by name or college |
| **Students** | `/student_list/` | List, search by name/ID |

---

## Admin Setup
1. Create a superuser:
   ```bash
   python manage.py createsuperuser
   ```
2. Log into `/admin/` with the credentials.
3. Register the models (already done in `studentorg/admin.py`).
4. Use the admin to add/edit/delete Colleges, Programs, Organizations, Students, and OrgMembers.
5. Remember to **run migrations** after any model change.

---

## Frequently Asked Questions
- **Why does `create_initial_data` sometimes fail?**
  The script now creates Colleges and Programs first, ensuring the foreign‑key constraints are satisfied.
- **How do I add more search fields?**
  Extend the `get_queryset` method in the relevant `ListView` and update the template form.
- **Can I use PostgreSQL?**
  Yes – update `DATABASES` in `settings.py` and run `python manage.py migrate`.

---

## Contributing
Feel free to open issues or submit pull requests. Follow the standard Git workflow:
```bash
git checkout -b feature/your-feature
# make changes
git commit -m "Add feature …"
git push origin feature/your-feature
```
