
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendPublicationAcceptedNotification = functions.firestore
    .document('publications/{publicationId}')
    .onUpdate((change, context) => {
        const newValue = change.after.data();
        const previousValue = change.before.data();

        // Check if the publication state changed to 'accepted'
        if (newValue.state === 'accepted' && previousValue.state !== 'accepted') {
            // Get the FCM token of the user to whom the publication belongs
            const userFCMToken = newValue.user.fcmToken;

            // Send notification
            const payload = {
                notification: {
                    title: 'Publication Accepted',
                    body: `Your publication "${newValue.title}" has been accepted!`,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK',
                },
            };

            return admin.messaging().sendToDevice(userFCMToken, payload);
        }

        return null;
    });
    exports.sendPublicationRejectedNotification = functions.firestore
        .document('publications/{publicationId}')
        .onUpdate((change, context) => {
            const newValue = change.after.data();
            const previousValue = change.before.data();

            // Check if the publication state changed to 'rejected'
            if (newValue.state === 'rejected' && previousValue.state !== 'rejected') {
                // Get the FCM token of the user to whom the publication belongs
                const userFCMToken = newValue.user.fcmToken;

                // Send notification
                const payload = {
                    notification: {
                        title: 'Publication Rejected',
                        body: `Your publication "${newValue.title}" has been rejected.`,
                        click_action: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                };

                return admin.messaging().sendToDevice(userFCMToken, payload);
            }

            return null;
        });
exports.notifyAdminOnNewPublication = functions.firestore
    .document('publications/{publicationId}')
    .onCreate((snapshot, context) => {
        // Get the FCM token of the admin (replace 'ADMIN_FCM_TOKEN' with the actual token)
        const adminFCMToken = 'f1oFDw93TX2vK9dHzKB0Q0:APA91bG_gFOfWEPWbMwMkmOtvw8qHFLNKH6Heu2CX_oqwbvi9tMNrKbqR9KVj-mmF-E6HDFWwqT4e_7LgO6fdhLPDDuWGcyQ1wLwjSgL9NxC3IyGKqpPwk3GoUoq1isSo3P1Gkb3_Sq4';

        // Get the newly added publication data
        const newPublication = snapshot.data();

        // Send notification to the admin
        const payload = {
            notification: {
                title: 'New Publication Added',
                body: `A new publication "${newPublication.title}" has been added.`,
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
            },
        };

        return admin.messaging().sendToDevice(adminFCMToken, payload);
    });

