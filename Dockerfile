# Use official Python base image
FROM python:3.10-slim

# Set build argument for GitHub token
ARG TOKEN_GITHUB

# Set environment variable from ARG (optional)
ENV TOKEN_GITHUB=${TOKEN_GITHUB}

# Set working directory
WORKDIR /app

# Copy files
COPY . .


RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    libxrender1 \
    libxext6 \
    libfontconfig1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 5000

# Start the app
CMD ["python", "app.py"]