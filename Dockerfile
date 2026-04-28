# Step 1: Use the recommended base image [cite: 121]
FROM python:3.12-slim

# Step 2: Set environment variables [cite: 122]
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Step 3: Set the working directory inside the container [cite: 123]
WORKDIR /app

# Step 4: Install dependencies [cite: 124, 125]
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Step 5: Copy your project files 
# We copy everything inside 'projectsite' directly into '/app' 
# so manage.py is at the root level of the container.
COPY projectsite/ /app/

# Step 6: Expose the application port [cite: 127]
EXPOSE 8000

# Step 7: Define the startup command 
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
