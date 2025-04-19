# Setting Up a Free Domain with Freenom for The Video Collection

This guide will help you set up a free domain name from Freenom.com that will always point to your Video Collection server, even when the ngrok URL changes.

## Overview

We'll use the following approach:
1. Get a free domain from Freenom.com
2. Create a GitHub repository with a redirect page
3. Enable GitHub Pages for your repository
4. Point your Freenom domain to GitHub Pages
5. Update the redirect page whenever your ngrok URL changes

This approach is completely free and doesn't require any paid services.

## Step 1: Get a Free Domain from Freenom

1. Go to [Freenom.com](https://www.freenom.com)
2. Search for an available domain with a free TLD (.tk, .ml, .ga, .cf, or .gq)
3. Select a domain you like and click "Check Out"
4. Set the period to "12 Months Free" (the maximum free period)
5. Complete the checkout process and create a Freenom account
6. Verify your email address if required

## Step 2: Create a GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in (or create an account)
2. Click the "+" icon in the top-right corner and select "New repository"
3. Name your repository (e.g., "video-collection-redirect")
4. Make sure the repository is set to "Public"
5. Click "Create repository"

## Step 3: Upload the Redirect Files

1. In your local Video Collection project, run the server once to generate the ngrok URL:
   ```
   start-server-stable.bat
   ```

2. Run the update script to create the redirect HTML file:
   ```
   node update-freenom-redirect.js
   ```

3. Upload the "freenom-redirect" folder to your GitHub repository:
   - You can do this through the GitHub website by clicking "Add file" > "Upload files"
   - Or use Git commands if you're familiar with them

## Step 4: Enable GitHub Pages

1. Go to your GitHub repository
2. Click "Settings" (tab at the top)
3. Scroll down to the "GitHub Pages" section
4. Under "Source", select "main" branch and "/root" folder
5. Click "Save"
6. Wait a few minutes for GitHub Pages to deploy your site
7. GitHub will show you the URL of your published site (e.g., https://yourusername.github.io/video-collection-redirect/)

## Step 5: Point Your Freenom Domain to GitHub Pages

1. Log in to your Freenom account
2. Go to "My Domains" and click "Manage Domain" for your domain
3. Click on "Management Tools" > "Nameservers"
4. Select "Use custom nameservers"
5. Enter the GitHub Pages nameservers:
   - ns1.github.io
   - ns2.github.io
   - ns3.github.io
   - ns4.github.io
6. Click "Change Nameservers"

7. Alternatively, you can set up a CNAME record:
   - Click on "Management Tools" > "DNS Management"
   - Add a CNAME record:
     - Name: www (or @ for the root domain)
     - Target: yourusername.github.io
   - Click "Save Changes"

8. Wait for DNS changes to propagate (this can take up to 24-48 hours)

## Step 6: Update Your Domain When ngrok URL Changes

Whenever you restart your server and get a new ngrok URL:

1. Run the update script:
   ```
   node update-freenom-redirect.js
   ```

2. Upload the updated "freenom-redirect/index.html" file to your GitHub repository
3. GitHub Pages will automatically update your site with the new redirect

## Using Your Domain

1. Share your Freenom domain with others (e.g., yourdomain.tk)
2. When someone visits your domain, they will be automatically redirected to your current ngrok URL
3. Even when your ngrok URL changes, your domain will still work as long as you update the redirect page

## Important Notes

- Free Freenom domains need to be renewed every 12 months
- Set a reminder to renew your domain before it expires
- GitHub Pages has a soft bandwidth limit of about 100GB per month
- This solution still requires you to keep your computer running for the website to be accessible
- The ngrok free tier has session time limits (typically 2 hours)

## Troubleshooting

### Domain Not Working

- DNS changes can take up to 24-48 hours to propagate
- Make sure your GitHub Pages site is published correctly
- Check that your Freenom domain is active and not expired

### Redirect Not Working

- Make sure you've updated the redirect HTML file with the correct ngrok URL
- Check that you've uploaded the updated file to GitHub
- Wait a few minutes for GitHub Pages to update

### ngrok Issues

- If ngrok isn't working, see the [NGROK_TROUBLESHOOTING.md](NGROK_TROUBLESHOOTING.md) file
- Make sure your server is running and accessible via the ngrok URL
