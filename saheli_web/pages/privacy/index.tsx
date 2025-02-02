import React from 'react';
import styles from './Privacy.module.css';

const Privacy = () => {
  return (
    <div className={styles.container}>
      <h1 className={styles.header}>Privacy Policy</h1>
      <p className={styles.updatedDate}>Last Updated: January 30, 2024</p>
      <p className={styles.paragraph}>Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our women&apos;s safety app.</p>
      
      <h2 className={styles.subHeader}>Information We Collect</h2>
      <p className={styles.paragraph}>We may collect the following types of information:</p>
      <ul className={styles.list}>
        <li><strong>Personal Information:</strong></li>
        <ul className={styles.subList}>
          <li>Name, email address, phone number, and other contact information.</li>
        </ul>
        <li><strong>Location Information:</strong></li>
        <ul className={styles.subList}>
          <li>We may collect your location data to provide safety features.</li>
        </ul>
      </ul>
      
      <h2 className={styles.subHeader}>How We Use Your Information</h2>
      <p className={styles.paragraph}>We use the information we collect for various purposes, including:</p>
      <ul className={styles.list}>
        <li>To enhance user experience and personalize content.</li>
        <li>To provide and maintain our women&apos;s safety features.</li>
      </ul>
      
      <h2 className={styles.subHeader}>Security</h2>
      <p className={styles.paragraph}>We prioritize the security of your information and take appropriate measures to protect it. However, no method of transmission over the internet or electronic storage is 100% secure.</p>
      
      <h2 className={styles.subHeader}>Changes to This Privacy Policy</h2>
      <p className={styles.paragraph}>We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.</p>
    </div>
  );
};

export default Privacy;