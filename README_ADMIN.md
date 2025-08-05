# Tenkasi DIC - Document Management System

This is a complete document management system for the Tenkasi District Industries Centre website. It includes an admin panel for uploading and managing documents, and dynamic document loading for the frontend.

## 🚀 Quick Start

### 1. Prerequisites
- **XAMPP** or **WAMP** installed
- **PHP** 7.4 or higher
- **MySQL** database
- **Web browser**

### 2. Installation Steps

#### Step 1: Start Your Web Server
1. Open **XAMPP Control Panel**
2. Start **Apache** and **MySQL** services
3. Make sure both services show green status

#### Step 2: Place Project Files
1. Copy your project folder to: `C:\xampp\htdocs\` (for XAMPP) or `C:\wamp64\www\` (for WAMP)
2. Your project should be accessible at: `http://localhost/your-project-name/`

#### Step 3: Run Setup Script
1. Open your browser
2. Navigate to: `http://localhost/your-project-name/admin/setup.php`
3. This will automatically:
   - Create the database
   - Create necessary tables
   - Set up upload directories
   - Import existing documents

#### Step 4: Access Admin Panel
1. Go to: `http://localhost/your-project-name/admin/`
2. You should see the admin dashboard

## 📁 Project Structure

```
TenkasiDIC--FrontEnd/
├── admin/                          # Admin Panel
│   ├── index.php                   # Main admin dashboard
│   ├── setup.php                   # Setup script
│   ├── js/
│   │   └── admin.js               # Admin JavaScript
│   └── api/                       # Admin API endpoints
│       ├── config.php             # Database configuration
│       ├── dashboard.php          # Dashboard statistics
│       ├── documents.php          # Document management
│       ├── upload.php             # File upload
│       ├── delete-document.php    # Document deletion
│       └── download.php           # File download
├── api/                           # Public API
│   └── documents.php              # Frontend document API
├── document/                      # Document storage
├── Incentive Page/               # Incentives page
├── Schemes/                      # Schemes page
└── LandingPage/                  # Landing page
```

## 🔧 Configuration

### Database Configuration
Edit `admin/api/config.php` if you need to change database settings:

```php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'tenkasi_dic');
```

### File Upload Settings
```php
define('UPLOAD_DIR', '../document/');
define('MAX_FILE_SIZE', 5 * 1024 * 1024); // 5MB
define('ALLOWED_TYPES', ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']);
```

## 📖 How to Use

### Admin Panel Features

#### 1. Dashboard
- View total documents count
- See documents by category (Incentive/Scheme)
- Monitor total file size
- View recent activity

#### 2. Document Management
- **Upload Documents**: Drag & drop or click to browse
- **Edit Documents**: Change title, description, category
- **Delete Documents**: Remove documents permanently
- **Download Documents**: Download files directly
- **Filter & Search**: Find documents by category, status, or title

#### 3. Upload Process
1. Click "Upload" in the admin panel
2. Fill in document details:
   - **Title**: Document name
   - **Category**: Incentive or Scheme
   - **Description**: Optional description
   - **File**: Select PDF or Word document (max 5MB)
3. Click "Upload Document"

### Frontend Integration

The system automatically updates the frontend pages:

#### Incentives Page
- Documents are loaded from: `api/documents.php?category=incentive&active=1`
- The "Achievement of Incentives" link updates dynamically

#### Schemes Page
- Documents are loaded from: `api/documents.php?category=scheme&active=1`
- The "Achievement of Schemes" link updates dynamically

## 🔍 API Endpoints

### Public API (Frontend)
```
GET /api/documents.php?category=incentive&active=1
GET /api/documents.php?category=scheme&active=1
```

### Admin API (Backend)
```
GET  /admin/api/dashboard.php
GET  /admin/api/documents.php
POST /admin/api/upload.php
POST /admin/api/delete-document.php
GET  /admin/api/download.php?id={id}
```

## 🛠️ Troubleshooting

### Common Issues

#### 1. Database Connection Error
- Check if MySQL is running
- Verify database credentials in `config.php`
- Ensure database exists: `tenkasi_dic`

#### 2. Upload Directory Error
- Check folder permissions
- Ensure `document/` folder exists
- Verify write permissions

#### 3. File Upload Fails
- Check file size (max 5MB)
- Verify file type (PDF/Word only)
- Check server upload limits in `php.ini`

#### 4. Frontend Not Loading Documents
- Check browser console for errors
- Verify API endpoint is accessible
- Ensure documents are marked as "active"

### Debug Steps

1. **Check PHP Error Logs**:
   - XAMPP: `C:\xampp\php\logs\php_error_log`
   - WAMP: `C:\wamp64\logs\php_error.log`

2. **Test Database Connection**:
   ```php
   <?php
   try {
       $pdo = new PDO("mysql:host=localhost;dbname=tenkasi_dic", "root", "");
       echo "Database connected successfully";
   } catch(PDOException $e) {
       echo "Connection failed: " . $e->getMessage();
   }
   ?>
   ```

3. **Test File Upload**:
   - Try uploading a small PDF file
   - Check if file appears in `document/` folder
   - Verify database entry is created

## 🔒 Security Features

- **File Type Validation**: Only PDF and Word documents allowed
- **File Size Limits**: Maximum 5MB per file
- **SQL Injection Protection**: Prepared statements used
- **XSS Protection**: Input sanitization
- **File Access Control**: Direct file access restricted

## 📊 Database Schema

### Documents Table
```sql
CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    filename VARCHAR(255) NOT NULL,
    original_filename VARCHAR(255) NOT NULL,
    category ENUM('incentive', 'scheme') NOT NULL,
    file_size INT NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### Activity Log Table
```sql
CREATE TABLE activity_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50) NOT NULL,
    document_id INT,
    title VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE SET NULL
);
```

## 🚀 Deployment

### Local Development
1. Use XAMPP/WAMP for local development
2. Access via `http://localhost/your-project/`

### Production Deployment
1. Upload files to web server
2. Configure database connection
3. Set proper file permissions
4. Update domain in configuration files

## 📞 Support

If you encounter any issues:
1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Check error logs for specific error messages
4. Ensure proper file permissions

## 🔄 Updates

To update the system:
1. Backup your database and documents
2. Replace PHP files with new versions
3. Run setup script to check for new database changes
4. Test functionality

---

**Note**: This system is designed for the Tenkasi DIC website and includes specific features for managing incentive and scheme documents. The admin panel provides full control over document management while the frontend automatically displays the latest documents. 