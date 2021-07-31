#!/bin/bash

# Initialize Variables ############################################################################
PLANK_SEPARATOR_FOLDER=$HOME/.local/share/plank/plank-separator
ICONS_FOLDER=$PLANK_SEPARATOR_FOLDER/icons
SEPARATORS_FOLDER=$PLANK_SEPARATOR_FOLDER/separators
SCRIPT_PATH=$PLANK_SEPARATOR_FOLDER/plank-separator.sh
declare -a ICONS=(
    "separator-white-vertical.png"
    "separator-black-vertical.png"
    "separator-white-horizontal.png"
    "separator-black-horizontal.png"
    "separator-blank.png"
)

# Create Required Folders #########################################################################
mkdir -p $PLANK_SEPARATOR_FOLDER
mkdir -p $ICONS_FOLDER
mkdir -p $SEPARATORS_FOLDER
echo "Plank Separator Folders initialized: $PLANK_SEPARATOR_FOLDER"

# Copy Script to Folder ###########################################################################
if [ ! -f "$SCRIPT_PATH" ]; then
    cp "${BASH_SOURCE[0]}" $SCRIPT_PATH
    echo "Script Moved to $SCRIPT_PATH"
fi

# Copy Icons to Folder ############################################################################
for icon in "${ICONS[@]}"
do
    if [ ! -f "$ICONS_FOLDER/$icon" ]; then
        echo "Copying $icon to $ICONS_FOLDER"
        cp "./icons/$icon" $ICONS_FOLDER
    fi
done

while true
do

# Print Menu ######################################################################################
#clear
echo "################################"
echo "#       Plank Separator        #"
echo "################################"
echo ""
echo " 1. White - Vertical";
echo " 2. Black - Vertical";
echo " 3. White - Horizontal";
echo " 4. Black - Horizontal";
echo " 5. Blank Space";
echo " 6. Exit"
echo ""
echo -ne "Enter the number for the corresponding choice: "
read choice;
echo ""

# Process response ################################################################################
if !((choice >= 1 && choice <= 5)); then
  exit 0;
fi

if ((choice >= 1 && choice <= 5)); then
  SELECTED_ICON="${ICONS[choice - 1]}"
fi

# Create Separator ################################################################################


echo "Creating Separator..."
UUID=$(cat /proc/sys/kernel/random/uuid)
DESKTOP_FILE="$SEPARATORS_FOLDER/separator-$UUID.desktop"
DOCK_ITEM="$HOME/.config/plank/dock1/launchers/separator-$UUID.dockitem"

cat <<EOF > $DESKTOP_FILE
[Desktop Entry]
Version=1.0
Type=Application
Name=Space
Exec=nothing
Icon=$ICONS_FOLDER/$SELECTED_ICON
NoDisplay=true
EOF

cat <<EOF > $DOCK_ITEM
[PlankItemsDockItemPreferences]
Launcher=file://$DESKTOP_FILE
EOF

echo "New separator created: $DESKTOP_FILE"

done


