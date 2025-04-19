# The Video Collection

The Video Collection is a streamlined video sharing platform that focuses exclusively on user-created content. This updated version removes all pre-created videos and only displays content that users have uploaded.

## Project Overview

This project has been updated to focus on user-created content only. It uses HTML, CSS, JavaScript, and Node.js with ngrok integration for external access. The platform now shows an empty state when no content is available and only displays videos, images, livestreams, and shorts created by users.

### Stable Link Integration

The Video Collection includes options for creating a stable link that doesn't change, even when using the free version of ngrok:

- **Free Domain Name (Recommended):**
  - Get a free domain name from Freenom.com (like yourdomain.tk)
  - Point it to a GitHub Pages repository with a redirect page
  - Update the redirect page when your ngrok URL changes
  - Share your domain name with others
  - To use this method, run `start-server-freenom.bat`
  - For setup instructions, see [FREENOM_DOMAIN_SETUP.md](FREENOM_DOMAIN_SETUP.md)

- **URL Shortener Method:**
  - Create a custom short link (e.g., rebrand.ly/my-videos)
  - The link automatically updates when your ngrok URL changes
  - Share this permanent link with others
  - To use this method, run `start-server-stable-link.bat`
  - For setup instructions, see [REBRANDLY_SETUP.md](REBRANDLY_SETUP.md)

- **Other Free Options:**
  - Use other URL shorteners (Bitly, TinyURL)
  - Create a GitHub Pages redirect
  - Use free web hosting services (Netlify, Vercel, Firebase)
  - For more options, see [FREE_STABLE_LINK_OPTIONS.md](FREE_STABLE_LINK_OPTIONS.md)

- **Basic ngrok Integration:**
  - A temporary public URL is generated each time you start the server
  - A redirect page is created that always points to your current URL
  - To use the basic setup, run `start-server-stable.bat`
  - For ngrok instructions, see [NGROK_INSTRUCTIONS.md](NGROK_INSTRUCTIONS.md)

### Pages Included
- Home page (index.html) - Main landing page with featured and recommended videos
- Video page (video.html) - Individual video viewing page with comments and recommendations
- Channel page (channel.html) - User channel page with videos, playlists, and community posts

## Enhanced Features

### Video and Playback
- Video uploads with verification for longer videos
- Multiple video quality options (240p to 1080p)
- Adjustable playback speed (0.25x to 2x)
- Picture-in-Picture mode
- Video chapters for easy navigation
- Interactive video annotations
- Automatic video transcripts with search functionality
- Custom thumbnails with preview selection

### User Interaction
- Enhanced comments with threaded replies
- Real-time likes and dislikes
- Advanced sharing options
- Community posts and interactive polls
- Collaborative playlists
- Watch Later and Queue functionality
- Improved subscription management

### Interactive Elements
- Info cards and end screens
- Video recommendations based on viewing history
- Premiere videos with countdown
- Live streaming with chat
- Video analytics for creators

### User Experience
- Scroll progress bar
- Enhanced login/signup with persistent sessions
- Customizable UI themes
- Responsive design for all devices
- Improved accessibility features
- Toast notifications for user feedback

## Tech Stack
- HTML5 for structure
- CSS3 for styling and animations
- JavaScript for interactivity and advanced features
- Font Awesome for icons
- LocalStorage for client-side data persistence

## Project Structure
```
/
├── index.html          # Home page
├── video.html          # Video page
├── channel.html        # Channel page
├── css/
│   ├── styles.css      # Main styles
│   ├── video-page.css  # Video page styles
│   └── channel.css     # Channel page styles
├── js/
│   ├── main.js             # Main JavaScript
│   ├── auth.js             # Authentication
│   ├── video-player.js     # Video player functionality
│   ├── upload.js           # Upload functionality
│   ├── channel.js          # Channel page functionality
│   ├── video-page.js       # Video page functionality
│   └── advanced-features.js # Enhanced features
└── img/                # Images folder
```

## Setup and Running

### Prerequisites

- Node.js installed
- ngrok installed (download from https://ngrok.com/download)

### Configuration

You can customize your Video Collection by editing the `config.js` file:

```javascript
const CONFIG = {
  // Server configuration
  server: {
    port: 8080,                // Change the port number if needed
    maxPortAttempts: 10        // How many ports to try if the default is in use
  },
  
  // ngrok configuration for external access
  ngrok: {
    enabled: true,             // Set to false to disable ngrok tunneling
    subdomain: 'videocollection', // Custom subdomain (requires paid account)
    region: 'us'               // Change to your region (us, eu, au, ap, sa, jp, in)
  }
};
```

### Running the Application

1. **Start the server**:
   ```
   node server.js
   ```

2. The server will automatically start ngrok and create a public URL.

3. **Access the application**:
   - Locally: http://localhost:8080 (or another port if 8080 is in use)
   - Externally: The server will display your public URL when it starts
   - With a paid ngrok account, it will use your custom subdomain

## Using the Application

1. **Create Content**
   - Click the "CREATE CONTENT" button in the header to upload videos, images, or start a livestream
   - Fill in the required information (title, description, etc.)
   - Upload a custom thumbnail if desired
   - Click "PUBLISH" to make your content available

2. **View Content**
   - All user-created content will be displayed on the main page
   - Use the category navigation to filter content
   - Click on videos to watch them
   - Use the sidebar for navigation

3. **Empty State**
   - If no content has been created yet, an empty state will be shown
   - Click the "CREATE CONTENT" button on the empty state to upload your first content

4. **User Authentication**
   - Click the "SIGN IN" button to log in
   - Create a new account via the sign-up form
   - User sessions are persisted using localStorage

5. **External Access via Stable Link**
   - Share your permanent domain or short link with others to let them access your Video Collection
   - The link will look like: https://yourdomain.tk or https://rebrand.ly/your-custom-name
   - This link will always work, even when your temporary ngrok URL changes
   - To set up your permanent domain, see [FREENOM_DOMAIN_SETUP.md](FREENOM_DOMAIN_SETUP.md)
   - All content is stored on your server (restarting will clear all content)

## Technical Details

- The application uses a Node.js server with built-in ngrok integration
- Content is stored in memory on the server (restarting the server will clear all content)
- Uploaded files are stored in the `/uploads` directory
- The API endpoints are:
  - `GET /api/content` - Get all user content
  - `POST /api/content` - Create new content
  - `GET /api/content/:id` - Get content by ID
  - `POST /api/upload` - Upload a file (thumbnail, video, etc.)

## Browser Compatibility

The application works best in modern browsers:
- Google Chrome (recommended)
- Mozilla Firefox
- Microsoft Edge
- Safari

## License
MIT
