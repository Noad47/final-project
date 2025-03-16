# שימוש בגרסה מעודכנת של פייתון
FROM python:3.12

# הגדרת תיקיית עבודה
WORKDIR /app

# התקנת חבילות מערכת נחוצות
RUN apt-get update && apt-get install -y \
    build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# העתקת קובץ התלויות
COPY requirements.txt /app/

# התקנת התלויות
RUN pip install --no-cache-dir -r /app/requirements.txt

# העתקת שאר קובצי האפליקציה
COPY . /app/

# הגדרת משתני סביבה
ENV DATABASE_URL=postgres://statuspage:password@db:5432/statuspage
ENV REDIS_URL=redis://redis:6379/0
ENV SECRET_KEY=your-secret-key
ENV STATUS_PAGE_CONFIGURATION=noa-statuspage.statuspage.statuspage.configuration
#./noa-statuspage/statuspage/statuspage/configuration_example.py

# חשיפת הפורט של Gunicorn
EXPOSE 8000

# הרצת האפליקציה עם Gunicorn
CMD ["python3", "noa-statuspage/statuspage/manage.py", "runserver", "0.0.0.0:8000"]
#./noa-statuspage/statuspage/manage.py
