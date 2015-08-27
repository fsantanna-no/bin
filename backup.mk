.PHONY: ceu data rsync

all: ceu data

ceu:
	@echo 'Backup CEU... '
	mount /dev/sdb1 /media/BACKUP
	rsync -av --exclude *.ova		\
		  /data/ceu/ /media/BACKUP/ceu/
	umount /media/BACKUP
	@echo 'OK!'
	@echo
	@echo -e \a\a


data:
	@echo 'Backup DATA... '
	mount /dev/sdb1 /media/BACKUP
	rsync -av --exclude chico/.local/share/Trash/ \
	          --exclude chico/.thumbnails/        \
	          --exclude *.ova                     \
              --exclude *.vdi                     \
	          --exclude *.vmdk                    \
	          --exclude *.iso                     \
	          --exclude Xubuntos*                 \
	      /data/ /media/BACKUP/
	umount /media/BACKUP
	@echo 'OK!'
	@echo
	@echo -e \a\a

rsync:
	@echo 'Backup RSYNC... '
	rsync -e ssh -av        \
	      --max-size=3M           \
	      --exclude src/Telemidia \
	      --exclude *.o           \
	      --exclude Benchmark     \
	      --exclude medias_*.lua  \
	      --exclude src/Web       \
	      --exclude src/WebWare   \
	      --exclude src/brew/brew2/LuaBrew.zip \
	      /linux/src chico@chico.eng.br:Backup/src
