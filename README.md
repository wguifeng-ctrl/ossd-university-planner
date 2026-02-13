# OSSD University Planner (OUP)
## Ontario University Application & Credits Tracker

A complete Classic ASP + Access web application for Ontario high school students to manage their OSSD graduation requirements and university applications.

---

## 🚀 Quick Setup

### 1. Prerequisites
- Windows with IIS installed
- ASP enabled in IIS
- Microsoft Access (or ACE OLEDB provider)

### 2. Installation Steps

```powershell
# Copy project to IIS
xcopy /E /I C:\OUP-Project C:\inetpub\wwwroot\OUP

# Set folder permissions (IIS_IUSRS needs read/write to db folder)
icacls "C:\inetpub\wwwroot\OUP\db" /grant IIS_IUSRS:(OI)(CI)M
```

### 3. Database Setup

1. Access via browser: `http://localhost/oup/create_database.asp`
2. Click through to create all tables
3. Then run: `http://localhost/oup/universities/init_universities.asp`
4. This loads all 22 Ontario universities with admission data

### 4. Test Account
Default login after setup:
- Register a new account at `/oup/register.asp`

---

## 📁 Project Structure

```
OUP/
├── default.asp              # Main dashboard
├── login.asp               # User login
├── register.asp            # User registration
├── authenticate.asp        # Login processing
├── create_account.asp      # Registration processing
├── logout.asp              # Logout
├── create_database.asp     # Database setup utility
│
├── css/
│   └── main.css            # All styles (responsive, modern)
│
├── includes/
│   ├── db_conn.asp         # Access database connection
│   ├── functions.asp       # GPA calc, credit counting, etc.
│   ├── header.asp          # Page header template
│   └── footer.asp          # Page footer template
│
├── ossd/                   # OSSD Credit Tracker Module
│   ├── credits.asp         # Credit progress dashboard
│   ├── courses.asp         # Add/manage courses
│   └── course_save.asp     # Course form processing
│
├── universities/           # Ontario Universities Module
│   ├── list.asp            # Browse all 22 universities
│   ├── detail.asp          # University details
│   ├── matcher.asp         # Smart matching by GPA
│   └── init_universities.asp   # Load university data
│
├── applications/           # Application Tracker Module
│   ├── dashboard.asp       # Application status overview
│   ├── add.asp             # Add new application
│   ├── save.asp            # Application form processing
│   ├── ps_editor.asp       # Personal statement writing assistant
│   ├── ps_save.asp         # PS saving/versioning
│   └── rec_save.asp        # Recommendation tracking
│
└── 📁 DATA VERIFICATION TOOLS (New)
    ├── data_verification.asp   # University data validation dashboard
    ├── data_edit.asp           # Manual data editor
    ├── test_url_proxy.asp      # URL connectivity tester
    ├── official_links.asp      # Links to 22 university official websites
    ├── disclaimer.asp          # Data source warning banner
    ├── disclaimer_full.asp     # Full data disclaimer
    ├── USER_MANUAL.md          # Complete user manual (Chinese)
    ├── DATA_UPDATE_GUIDE.md    # Data maintenance workflow
    ├── DATA_SOURCES_AND_DISCLAIMER.md   # Data source documentation
    ├── BUGFIX_LOG.md           # Technical bug fix history
    └── AUDIT_REPORT.md         # Code audit report
```

---

## ✨ Features

### 📊 OSSD Credit Tracking
- 30-credit graduation progress bar
- Category breakdown (English, Math, Science, etc.)
- OSSD requirements checklist
- Course planner (Completed/In Progress/Planned)

### 🎓 GPA Calculations
- Cumulative GPA on 4.0 scale
- Top 6 U/M courses GPA (for university admissions)
- OSSD percentage to GPA conversion

### 🏫 Ontario Universities
- All 22 Ontario universities loaded
- Admission requirements (Min/Competitive GPA)
- OUAC codes
- Application deadlines
- Popular programs per university

### 🎯 Smart Matching
- Filter by admission chance (Safe/Target/Reach)
- Match score calculation
- Program recommendations

### 📝 Application Tracking
- Dashboard with deadline alerts
- Status tracking (Draft → Submitted → Accepted/Rejected)
- Deadline warnings (urgent <3 days, warning <14 days)

### ✍️ Personal Statement Editor
- 5-section writing guide:
  1. Opening Hook (引言)
  2. Academic Interest (学术兴趣)
  3. Relevant Experience (相关经历)
  4. Career Goals (职业目标)
  5. Conclusion (结尾)
- Bilingual writing tips (English + Chinese)
- Version history for each section
- Word count tracking

### 📨 Recommendation Tracking
- Track referee status (Pending/Submitted/Waived)
- Contact info management
- Request date tracking

---

## 📋 Data Verification & Maintenance Tools

### ⚠️ Important: Data Accuracy & Source

**System Data Nature**: The university admission data in this system is **reference/sample data**, not official real-time data from universities or OUAC.

**Data Characteristics**:
- Hard-coded in `init_universities.asp`
- Last updated: February 2026
- Includes 22 Ontario universities with estimated GPA ranges
- Major-specific differences NOT reflected (Engineering vs Arts have different requirements)
- Deadlines are estimated (actual deadlines vary by major and application channel)

### 🔍 Available Verification Tools

#### 1. Data Verification Dashboard
**Access**: `http://localhost/oup/data_verification.asp`

**Features**:
- Test connectivity to all 22 university official websites
- Quick "Test" button to verify website accessibility
- "Website" button to open official site in new tab
- "Edit" button to update local data
- Recommended verification workflow

**Usage Workflow**:
1. Click "Test" to verify university website is accessible
2. Click "Website" to open official site
3. Navigate to Admissions/Future Students section
4. Record latest GPA requirements, deadlines, required courses
5. Return to system and click "Edit" to update

#### 2. Manual Data Editor
**Access**: `http://localhost/oup/data_edit.asp?id=[UniversityID]`

**Editable Fields**:
- Minimum GPA (typically 3.3-3.9, varies by major)
- Competitive GPA (typical admitted student GPA)
- Application deadline
- ENG4U requirement (checkbox)
- Calculus requirement (checkbox)
- Popular programs list
- Update notes (data source and date)

**Important**: Must verify from official university website before updating.

#### 3. Official Links Navigation
**Access**: `http://localhost/oup/official_links.asp`

**Provides**:
- Direct links to all 22 universities' official admission pages
- Quick access to OUAC application center
- Admission difficulty tiers (High Reach/Moderate Reach/Target)
- Estimated GPA ranges by major
- OUAC 101 vs 105 channel deadline reminders

#### 4. Data Disclaimer System
- **Yellow warning banner** appears on all university-related pages
- Links to full disclaimer page
- Clearly states data is reference-only
- User must verify from official sources before decisions

### 🔄 Recommended Data Update Workflow

**Option A - School Guidance Office (Recommended)**
- System maintained by school counselors
- Update once per semester (typically October/November before application season)
- Verify top 10 commonly applied universities

**Option B - Individual User**
- When planning applications, verify 3-5 target universities personally
- Use `data_edit.asp` to update those schools only
- No need to update all 22 universities

**Verification Checklist**:
- [ ] Minimum GPA for specific major (not just general)
- [ ] OUAC code remains current
- [ ] Application deadline for correct channel (101 vs 105)
- [ ] ENG4U and Calculus requirements for intended major
- [ ] Any supplementary requirements (interview, portfolio, video)
- [ ] Document source and date in update notes

---

## 🗄️ Database Schema

### Tables
- **Students** - User accounts
- **Courses** - OSSD courses with grades/credits
- **Universities** - Ontario university information (manually maintainable)
- **Programs** - Specific programs per university
- **Applications** - Student's OUAC applications
- **PersonalStatements** - PS drafts with versioning
- **Recommendations** - Letter of recommendation tracking

---

## 🔧 Technical Details

### Stack
- **Language**: VBScript (Classic ASP)
- **Database**: Microsoft Access 2000-2003 (.mdb) with Jet 4.0
- **Connection**: OLEDB with Microsoft.Jet.OLEDB.4.0 provider
- **Styling**: Custom CSS with CSS Grid/Flexbox
- **HTTP Testing**: MSXML2.ServerXMLHTTP

### Important Coding Constraint
> **VBScript does NOT support `IIf()` function!**
> 
> Always use native `If/Then/Else`:
> ```vbscript
> ' Wrong:
> value = IIf(condition, "a", "b")
> 
> ' Correct:
> If condition Then
>     value = "a"
> Else
>     value = "b"
> End If
> ```

### Data Update Technical Limitations

**Why not automatic real-time updates?**

| Constraint | Explanation |
|------------|-------------|
| No Unified API | 22 universities have no standardized public API for admission data |
| JavaScript Rendering | Modern websites load data dynamically; Classic ASP cannot parse JavaScript |
| CORS Restrictions | Browser security prevents cross-domain data fetching |
| OUAC Authorization | Official OUAC API requires educational institution credentials |
| Major Variations | GPA requirements vary dramatically by major (3.9+ for Engineering vs 3.3+ for Arts), cannot be simplified to single university number |
| Structural Changes | Web scraping rules break when websites redesign |

**Practical Solution**: Semi-automatic verification + manual update is most maintainable for Classic ASP environment.

---

## 📚 Documentation

| Document | Purpose | Location |
|----------|---------|----------|
| `USER_MANUAL.md` | Complete Chinese user guide | `/oup/USER_MANUAL.md` |
| `DATA_UPDATE_GUIDE.md` | Data maintenance workflow | `/oup/DATA_UPDATE_GUIDE.md` |
| `DATA_SOURCES_AND_DISCLAIMER.md` | Data source explanation | `/oup/DATA_SOURCES_AND_DISCLAIMER.md` |
| `BUGFIX_LOG.md` | Bug fix history | `/oup/BUGFIX_LOG.md` |
| `AUDIT_REPORT.md` | Code audit findings | `/oup/AUDIT_REPORT.md` |

---

## 🎨 UI Features

- **Responsive Design** - Works on desktop and mobile (breakpoints: 768px/1024px)
- **Ontario Education Blue** (#003366) branding
- **Progress bars** for visual credit tracking
- **Deadline badges** with urgency colors
- **Card-based layout** for easy scanning
- **Data source warning banner** (yellow) on all university pages

---

## 📝 Next Steps / Enhancements

Potential future additions:
- [ ] OUAC fee calculator
- [ ] Scholarship database
- [ ] 12th grade course recommendations based on program requirements
- [ ] Email reminders for upcoming deadlines
- [ ] Export applications to PDF
- [ ] Document upload (transcripts, portfolios)
- [ ] Automated OUAC API integration (requires institutional credentials)

---

## ⚖️ Liability Disclaimer

This system is a **planning tool**, not an official information source. Users must:

1. Always verify admission requirements directly from university official websites
2. Consult with school guidance counselors for major decisions
3. Submit official applications through OUAC (ouac.on.ca)

The developer is not responsible for application decisions made based on system data.

---

Built for Ontario Grade 11-12 students navigating the university application process.

**Project Source**: `C:\OUP-Project`  
**Deployment**: `C:\inetpub\wwwroot\OUP`  
**Last Updated**: 2026-02-13
